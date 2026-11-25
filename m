Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591395;
	b=MTEZs60UzhRya8IsjmE4R9w6aVlXXjmPBOmac0LqYx3wzXOCPYXADKDgU5JCU2EIMqER
	 hTaTE9FqHuyIOlSkI2Jn9ND3CckJX3f6lcCD7NufJfs2nqZsD8goK85wSZ63GbK6XMgHj
	 /ixDjGHUnSJy6gpfBQqyKHGfSBdhzLnM9/DLSLszpy3AtjDY9dRKTlRHPiawy/CyrtKKo
	 VapIpo5yarehMlld8s2q6XsyBG0y4tqwmzO5lo8uSHg3JAlG0qSOgr+bYEAzNu9u7Ruz5
	 BWCyTYqxaZGUEaGeutR3Hu+EzktUOUVxyNzG2+Z8rg2wDhl2l2up1VjsAO7YzZp0LzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=sr/IMCDoL+dmuU9nsYz2JXuc65bch7AyROLr2lOtxZpHV3MOt+QLmceUs9GhWyDpbJP/
	 pc2qaRYC0Tg7EBX915kOTHe5GS41iaTm7608nWxLjnO0RKAsf72dTDucDUR/Uj3ZuPx9u
	 U4XlEd0Js45hmCR+mk+OSBFoQZ99K3LphQZ6yoJqHUPC8hQVtB0b+sY/pyOJrEkpWJLSc
	 CYFF8r7D2iV+o2uod273DnuMcPblt3RHhtatnL5J2BKt6LQXhwpd27UC2aCksyJHuzo37
	 Zr2duz/qTctNLNFKR6AP2oeX2fWjxsR8Bb5PKYuwfs4bh88vmVgNKiuzG36waW+Ipbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TD4gzTqv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F86606A329;
	Wed, 25 Nov 2026 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TD4gzTqv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7351F000C4;
	Wed, 25 Nov 2026 07:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591394;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TD4gzTqvAdhgYjNRjvxRd5HqYQrP3TqqXWiAOcGwpPj9W4iBEEOJ8u4W5C9Sa++Gj
	 IWYUMIBVzplHqNo7sr2XRxOaE6mFmMdYgEKqi4IzYf0aQ8u2jUiUQBnvykZSYK3y6B
	 OzCRxRInnC+w4Wws3cXH7j3IU9fYao3jaSjt+Pml6erHGw6fzFplVVDTFAog3q/gUg
	 M5+JsQmhUjr+3YNY19/hY1+jCF2sby3DFIfIPF3ux2t8qsk94+5EnjyQF60UXb2Det
	 M46DEY5MEUNjRXTu/a+lTpDQJiYfTYg/p+nJl+FOfksew/oMumTp1YUabjFV+/rbfF
	 qEdnowb7ewfvQ==
From: netdev-bot+sinfo@kernel.org
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] net: usb: mcs7830: skip zero-length register dump reads
Date: Wed, 25 Nov 2026 07:23:13 +0000
Message-ID: <179559139369.3294.9096901907598908535@kernel.org>
In-Reply-To: <20261125071649.7052-1-25031212351@stu.xidian.edu.cn>
References: <20261125071649.7052-1-25031212351@stu.xidian.edu.cn>
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
