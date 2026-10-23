Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785302;
	b=mK3ezIVGw7M4RvxEhM3dT6c1wkUETk1fO/yxT+reZtTwi2bGtkS6OJcfEGpJQHpHfzob
	 Y4Cnu7rV69KRpUuCIhL1v8YDDet9iPCXUaQwVCc+ewcjNpSAjpsipQ6um+LQAiGwZWwuD
	 +Mva2PLFw7kjK96w+MOjcpzhrFt2EdJIpfAHwBF4FOHJgBy5feRys+oxt6yzHs+jnwA8c
	 3fsC3MGUWygeEvFIUibLx/825VFsy6BlFsMWxfy+EuZ3bydOlSe06F2V6rJWsxZ+8ncWV
	 PNB7eHD+XtwOgq50Xkrn2TfIK3LEamfpO17EEzfjWlKX331SM14cAHFL8vUxgJwiKwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785302;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=RN1MwGFQXwGob85hUTGvofn9z6tKKGKdNL6+mwIz8DgVgYQNF30SLHkTvHvY237N4iu4
	 7rlr/XZH82hMoSsKU3XhjBKRRhMv5byMiheiv/6x0hNf74wP/CXGYijloUO14q+LCCffV
	 eNV43KFqFbYG20lLRg5oIJcAkmSvpRItcJZn1rXS2OToA6AUClewU1fueGuK/R28OcW6U
	 CJZ8SPcJVpbDN+4N34FbgtN0s/32wR8qJnnei0GC9hJ2q/SXDqheZkD4A3YGeV0/VQJYH
	 4e7IRoPFg0tP5JRZovhWxkQmjeIbiu0Wr9k895+qTPIp+p6Ad2vCD7QeMDSjQYvO9xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6hR1sIP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B860A2610;
	Fri, 23 Oct 2026 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6hR1sIP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9B01F031E4;
	Fri, 23 Oct 2026 19:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785301;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O6hR1sIPnyQzvbQK8WkVWIULWirtLcio7VqM+OP35DUcgThdZOkfBRPRYBUOUxI6v
	 r9WLLKzyyyrPyYU/3+cf5TWN0dx3ERBUkGA7wUzY98MpXzJV0KxNGbM3zHmtkAsecS
	 DVg5qCIQg6P9iAXlT0Z5cWloNfn/u3Yabq7aS8vtFN3Zo52a14yK1uCNCcf0ksyDW1
	 nPhchs+TdacGpJgEjl55LyY36d82vpldM2qkx4dA+EF6hxnwFvPQS2L91UfLMpIUB2
	 vt4gzx2h8csu0eMgD91VRooeQp5jclSDwKbijmK+nZozFPHriZ3pSHTtUm16A3X5RG
	 zRyjI9M5uLuKA==
From: netdev-bot+sinfo@kernel.org
To: Tristan Madani <tristmd@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Qingfang Deng <qingfang.deng@linux.dev>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH net] ppp: fix stale pointer access after pskb_may_pull in
 ppp_ccp_peek
Date: Fri, 23 Oct 2026 19:55:00 +0000
Message-ID: <179278530053.3327.8146002814113286756@kernel.org>
In-Reply-To: <20261023195309.3527129-1-tristmd@gmail.com>
References: <20261023195309.3527129-1-tristmd@gmail.com>
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
