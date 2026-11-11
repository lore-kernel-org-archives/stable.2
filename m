Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434333;
	b=f+ewGULiLZcfiWq5KnZ7+u1RDn20vxiTOyLU27WxTR/E8qAXhT76GkU30xlWmtL8ulVN
	 HqSihfSFIMA4q5PfS3Kl6CNtIC9S1q3acCr6Nrd81sXC4ay6zsnv64xyWe0/CgI0n2twp
	 RCeNiPx8u2pUW10u14mgR2qMdlp8aYoUjbdOgpNYwcoDlcpNn0EEXAseJYQtYO1r9A7UX
	 91VrQRaaDPciSPFwJC8+reqFY4Q72OxC65nKJ2Q6awabLLFbzXEd9Hqxj14Wopvy4+DPi
	 Q2bBxiYYqAqsbuWJmfF2iE94s7E0rQEPJIbQ+X5DxhjiE3Hsmcwy8cP0KXPpGrmgPDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434333;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=Bzy/HWiS2g+uLlnxE35P9YvJAj3yVSHdky07Sp8MJkc=;
	b=s0B1w+rEIIVnOph4P1haPi32tm90t7gmOLCrOsgEgFnm12dmQ5tdD9W8tyaLTEo+tWYl
	 cV+RB7tGc6fNRxsn4pPRAfnKpN6vCHUQo/b/FNsYlfznsDTgD9etIe2BbOjYTKY3qBO2w
	 /2R4fUqgUFgfo8/dMniYNkybRyAVyEY1fkU7b6m7qMkiKV4UqkjaWzJsF08+5GPkYTcCd
	 gMvyAPWIr6CBv2uvTnihQtyGoDIuFhSQ48cZpAoiybUnAbrdQBXyZD0XAafbV8uHN45py
	 8PJspmtcDVSYIr/atcQLfhwc4NPP1jkYrPWJEvf9sBzejQQVujZpHGhLc47gW+b1yLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=AQRGB0tq;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A4160A2601;
	Wed, 11 Nov 2026 21:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A4160A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=AQRGB0tq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Bzy/HWiS2g+uLlnxE35P9YvJAj3yVSHdky07Sp8MJkc=; b=AQRGB0tqgq7wA77y/mB9wLAZ+j
	UJgj8b2JNk/rb+fcJAg0ntpM2euoZy57H+0RViotqL6EEXtptfRNY8Y3QMlm6TMmn+PGtdSV0eB7J
	GuLDsIgt9h7hbNZ0iLYEkytkMDZjAYgH6H9rJNzmCtUcH0etxbAbvDMwlz9tudnzwEJNW/xnHWg3R
	81azx56g0V32mYp7q+HFTnZZggNkABHDDFxNZqIb7QEl3Gd1De6YKf46ax5Qy5NlQaC71qXTUCof9
	3I1jrO+V+dk4HPBhQiEnneO1BJMUvGRst0SZgB+OhEAhKze/IZzbI3rLL1A9zlMV/6Kw+1s84Rpwm
	D8+iBFMg==;
Received: from [::1] (port=34640 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xRGLE-0000000CB0C-0h27;
	Wed, 11 Nov 2026 22:58:51 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 11 Nov 2026 22:58:51 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: netdev-bot+sinfo@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] udp_tunnel: fix GRO callback mismatch during setup
In-Reply-To: <179443388157.2168702.6402576631905322740@kernel.org>
References: <20261111214622.2482547-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179443388157.2168702.6402576631905322740@kernel.org>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <da59c8b8ee9d133dcebeabb40818959e@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-11 22:51, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

The bug was discovered by code inspection assisted by LLM.
