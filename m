Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566528;
	b=KEh1e8sTGWLrg5hhzHczW7RAn/DaFStVOXNHIcNyQ2lvmoGSM3eKqLXg/cA43Fyt5PRP
	 4iP9FmwkylkDDetJ5RgK+ualTAU1PzmWhNl/A+Zzt5N6Z64X+1XW4MzW3igiHp1oeVczB
	 y2yvv7mgFvmDYkx6z9CoG0KYkMCkYUoBviyYm9BVWleqqlm16bOCfiVNoKzXgV/KksLT/
	 Yk1Mw7J1ucM1vOzr3NCo767yHC4QJyG1o85Q88zZBONaF03NKjLKJaLmtusCz7rMnA4Yf
	 RsIFZ3BbxFGK7H51x0qOlM9IbVhgTvQCJjzyZqQyM0IBSoyKA5W5i+ikarOWzxvGYsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=0ZUvFL2FKq6LB7JSO+TH0cqVV+G54dDf+LnvqKVGABidtV82O4NY9buzuU2rWWkDyd+C
	 2OyI3Gvdm1+BIWtxKV+a9+JjIDXU0/v6EQnKnWxN96KB9WEA7Zk5aBT2wOURceUiMRWKg
	 tPWZACrCgH9Fd+QqrSeHuGEI8qG0pWPA+1VyYPtUSr0mmmeaDC1MgAb+sMdbt9qrErw7F
	 9pN4ClSBQhcMH7n4CsdAqb6AbvIAksxg4k81Gxhpr5STe8h4lPO0BL0VCPULbMRQJ1d6q
	 o2mE0GWisQFixgYhi57qW2QNz+BNiwAcr62Sfr1xLzQefG/ZunGXVjZdPVckw/WOhYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RybRCxCl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5892606A31E;
	Wed, 25 Nov 2026 00:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RybRCxCl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA0F1F000C0;
	Wed, 25 Nov 2026 00:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795566528;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RybRCxClnsZI12/r0IPs/JwuTHfiOksKoPM1HN+TMPmyfzsdw6MrYTbsczi4Dil97
	 69xSPXvk8jtpBN59VF4XuxY/Tz7eK3FUvXzytNwTFSFzwqRLK8x9NoshB1bdtsjukg
	 XD1x7ImoX26GcsDfdEBhzMDErhClRJB8uSyZOwVSVB/7dV2uBxmSsFlD2BPUTPPq3i
	 0Qg1taruI0JLa0sS+hhpVhYqheZ/DZfZTKwCzHdcHlPs0VRXF8mBRQ4oOA2m08v7Sc
	 MgAEqW8amv7mgdrbCYacTPYCpdK7Wjbyc/YYBNRelgBvPwTJTphWYAvlenYYIymwc8
	 mXN3tI0wv6DCg==
From: netdev-bot+sinfo@kernel.org
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 stable@vger.kernel.org
Subject: 
 Re: [PATCH net 1/7] ovpn: avoid sending UDP packets with source port 0
Date: Wed, 25 Nov 2026 00:28:47 +0000
Message-ID: <179556652736.3294.18442154339903637484@kernel.org>
In-Reply-To: <20261125002239.1191542-2-antonio@openvpn.net>
References: <20261125002239.1191542-1-antonio@openvpn.net>
 <20261125002239.1191542-2-antonio@openvpn.net>
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
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
