Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483463;
	b=nn+rgOV0mgR+3yNmfsLaQbMH415ewZ9jucVBuFgMj1T9p0E7DpFp+cIJI/rZLMmbcKPT
	 a3D3qVkMX9WXzkUYDDHYLCB460NqLoXWTJ356O2Sw3umnUXYqqwScqQdYEAuvzjLA5LXE
	 CrYWiQ7b+YqecfOUYwImBIeRKLlEJp4K3YKv5k4EnWUqXfy04yFQOKaPyDe37qibbTYlQ
	 a7rdl7hFHZK5ZbmO/ZkoVirCmZ3zpybDDHu8Kaq8tjmTsgdAXlSAqhjSLQDT2xdcWf1Zp
	 JBjLKOY8A5x4I9S212z95wnXOeGHgqD2C7eMm1FpFOZ/uoCeth5n5rD2QGZC8x+nrnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483463;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=r1apn0rse9yrbGp949MhUou2z747LInhZntky023sh39EhIX96N6MVQ+PXH+VKPYcOdv
	 KCGUOu/78Nn7+eDNEha6Zo7WViWuYmMUJHNzRDb/S7lm0A30MjXSZ6fU4bS0BiVEGg45u
	 +GBa1VVbozS8+6UHUmWGXZOkXLd9B2GUh7jArkhbdYbr73P+K1cxKnQrOAUPgzQ5dzfyw
	 tJEZgUk5dzqIuMIrsWt8EUKfpa9tx6CzdMUlVsqaHB4HcXKdwJ0s/nisuqVsjnBUFIEod
	 DQ2NyPYF0whdGsfhOD2kEZ7kIv3MygBRfFGhORRdGWu7P4rVQnwz7gT+WXQYbSVVNXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CT9XujEv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F8606A319;
	Tue, 20 Oct 2026 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CT9XujEv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4997E1F000C4;
	Tue, 20 Oct 2026 08:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483462;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CT9XujEv8qyVL5es+LW22rM7MFgjushdbgd9qHIXvjXTdrQUTLjQIIZf/KkJDTRMj
	 1zBt8eqtZdbUHn1XWSD/DqPBuETv0S2IIRgpkSTRWt+3XdRxw2iMDsTMRwSLg0U1nl
	 cSaFIwe+eRoHGXuq1lG4pYiHO+gS++UsknTs8o7pKtCfPgNhV4DTJiBSo7HgSRba8a
	 cCXD3gNJ7jpwQO30xHrpYC9hy6+pN8mKRt1pm2ltCMxb2o7HAJTRiJEoZz6slM/Wcy
	 gVi9zvuD5bfpUsY80Xi5XSE2PcDwfO8dKmd1J3pjHHxvz/KMV8rRgk6z2XZ8s4sMHi
	 crTNE9pRe5c9w==
From: netdev-bot+sinfo@kernel.org
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, mkl@pengutronix.de,
 kernel@pengutronix.de, haibo.chen@oss.nxp.com, shawnguo@kernel.org,
 imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v5] can: dev: can_fill_info(): don't wake up controller if
 interface is down
Date: Tue, 20 Oct 2026 08:04:21 +0000
Message-ID: <179248346178.3290.6150529956117056026@kernel.org>
In-Reply-To: <20261020075340.417899-1-chunyuzhiqiang@yinhe.ht>
References: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht>
 <20261020075340.417899-1-chunyuzhiqiang@yinhe.ht>
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
