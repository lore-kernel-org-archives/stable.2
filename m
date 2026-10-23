Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785317;
	b=YPCeRnm4kDg4sOG0Yj9ZiTDzuq8ULD9+C3va0TZsTfCRzkEfzsyZPNyk0A7+gJqidMsP
	 wqq9j1Svnpkb2N5fZp8tjvF63P4P4EWTJ04hmfBZ7OkzJStCsbuYRAcDvb2+Tvdbpjir0
	 B4JrF/YzcNVqz1uH1XSc9qtNeSsgvJg0newRltWFaGheH/IIh4PXy+cTmyhEt6qK52WhU
	 Wpr/CH00PwTBKMbfZsM5eU0uzOgFX1mPakmSoGDCIOlsCvlx5GlFu2hVXl0kzgZjX0wip
	 t9fxSdmTPrKG2RiTK18/vybbjPUpNrOIkTxDhfjpm4VtdXIvZ5tf8g9dCGnnU01efmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785317;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=W1euj5esfQUV6arn2+bQwZZriodpXfjqOazuxReMofhlApLVP4hKkpPHHYzjVS1taEin
	 caBB7O1ltN3vCC6RKNuaJiq9lMghFZI82w6Z1F4G4tIYqP+WCQCVt2yo+pe/8whSFgXEv
	 KqQ+NVoCABFTt45wP6S1Vgn2lkOSbIPltDUBDi99mk5OOMHkO/prSZAb+JezvO1gg87l5
	 HWFQlomAbh32G6hx+ltnxkiHudqogc5B7D3ra5XwW/EqPobeKZdUmPjlt1u8BqOFNlOzZ
	 +WM2wp2EzSu13po39TK2qqZ8h0NF7IPoAij7EoRQC47xxFYSCYLEty5w1gKdOWhrTtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gpq1ObWT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE9960A2621;
	Fri, 23 Oct 2026 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gpq1ObWT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23FD1F031E2;
	Fri, 23 Oct 2026 19:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785317;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gpq1ObWTktKZuuubqFVfVfiniNjgPAIjekKyny9Yi0OF+xSzdH2G3+MuW74A4YJMn
	 /VRqUI8PkKy/PRWaNFjBAK/XUwcVD56neAkovao4AAtQ6rhsxoaQChsDNRYsrQjgtl
	 SQmAeSWfX2OOmXdvgZsZy+cxqYbNEU160qB+6GA8GpH2T+2DNxx0PUg7sUQwxXLLUp
	 SIFzPzo1BUImPk3unihU7xuckmonLH57Ycq8ekMR3No3/PdZ/jcLZoyem3owEDniys
	 sLx7lmhny7X0QswkvkNdaOZj6dTCh0/NuOX0Ukd2qblAprBTW6DpiV3uU2Db2/fMF7
	 6JAt5PANvmArg==
From: netdev-bot+sinfo@kernel.org
To: Tristan Madani <tristmd@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "John W . Linville" <linville@tuxdriver.com>,
 Samuel Ortiz <sameo@linux.intel.com>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: 
 Re: [PATCH net] nfc: llcp: use timer_shutdown_sync to prevent timer rearm
Date: Fri, 23 Oct 2026 19:55:16 +0000
Message-ID: <179278531637.3327.11947058101101849130@kernel.org>
In-Reply-To: <20261023195409.3532540-1-tristmd@gmail.com>
References: <20261023195409.3532540-1-tristmd@gmail.com>
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
