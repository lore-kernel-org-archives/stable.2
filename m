Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459384;
	b=OsViYd4B7FlzHOw339wZzbN/i9390fKwPrhH1jKTqmVFK25oynJUpir0kpQwKOeGkwt1
	 YAccFrk4M+g/9QRk8JFy6l5lvGb9Oyqi9AEdjVhndwzi9pM76Q58R/ez+fkXlAYdJMfBp
	 nR/ygvKxLwbiFhE7vJEQp19Z2x+XcwJTZtOtdY5MVvgoc7et9KpAaitfV0D1WOpr7hRjA
	 0fAtIjMIxp1iyOXAr0sFwqiVOYgwgm21mtVWa4i1qulqyd5ZE1Ar1wEtkqBixMcw8vku4
	 6NnIqFahnTXzi8/VqkMf4bLME7OrtD3jMYNcjMS0+aPoylkH47ZN5dyrMscZHNSg2gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=WiHZQbEXJ49O24uu5auwKiVTLBVqartw7M7UCwDt5LbGIpHamDjat5+Axm8W5cAZPcEP
	 iR93ieOh2Wvrfs3HlHRE96bbobEzLBPU2IeygINbbWm48JL1BXrulkmNXsSBD3obA52WU
	 CQ8MNCNW9mEC0V5JqALH3lR2y5lG5bqa401Jko4pyiQOa7ErfNm1jWVVerIbcYWqmaAdI
	 /CDI7V8b15DU0Xyf2fkUk5n/VCI3SAcGUbnwPkktHSsnPoWD4FXHPXgwccnvi6LghQaG7
	 x6h/SWJlK+7eopv2NbUuQYQKInxS/jM7+sgg8mjJYreeK2eR0hBWqDQSoBEVabA+lPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mflBuajg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA1606A31F;
	Mon, 23 Nov 2026 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mflBuajg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68CB1F000C6;
	Mon, 23 Nov 2026 18:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459384;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mflBuajgM5aL9pUEJ8xBtmAs02kIkBvgVVT1uY5VYcnlh2WuVAGGGReCJdM+3tPNP
	 YQtOIVGmyshAUAYVOq9ogdy1lUXgYo32+T3EqFgS91uU/U9WvZJtb27DZA7rzbNmpl
	 VRnCdptiueP1xaTki56aXQcZL2Jz0TK4ITe8ytG3qJO4+dlJf2FtQoKCORUXRwS0SG
	 nADGSXe3pcDGYuHSiDy7jTx3lZvsxKq72xA972fuWW00AnHCgIdF+JWpLcShUdxQzH
	 jcodztroKLeGrIrOLY0hpuJjqbDXUStasV9JqsvQx1/c5LoayIXu7UHinDYbCIxMCO
	 EFe8mhHXUqoIA==
From: netdev-bot+sinfo@kernel.org
To: Tanuj Sharma <ertanuj96@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 linux-hams@vger.kernel.org, stable@vger.kernel.org, ralf@linux-mips.org,
 horms@kernel.org
Subject: Re: [PATCH] net: rose: fix OOB read in CCITT facility parsing
Date: Mon, 23 Nov 2026 18:43:03 +0000
Message-ID: <179545938321.3294.1755195689641183688@kernel.org>
In-Reply-To: <20261123183818.24508-1-ertanuj96@gmail.com>
References: <20261123183818.24508-1-ertanuj96@gmail.com>
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
