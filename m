Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502706;
	b=DGMcjgqt4S54HlytArCaJNfWvMbh8U4FtKUbGfQ+DyvT6/ft7g86i7rl7s0GHbWyZqqO
	 Sx5/6Y9wQPK2hzXLkOiXKJgtpMK+JJVsP2BHzhsAvpaVrDz5mR43b7S/lKXkmYQtPEMYS
	 bONFPGQ8SB7CpfZtmQQ1kk5SBQtuHmYU2QCcsVW1ht+GvpYw+YjX9qv8Q/lNUkqWtXBCt
	 WgbAlASyWKbjb2f36nkWW1I8l0BQygr0DfZ/RQufunr0qNZ0G/dU4v64s8zG0TP08BYri
	 2gt7IxHpKK3qxWhErgLKtB0AFEI/X3idyzdiZPC7WH4J4D1L+JZXDU5N0Qe6AJghgXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502706;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=yf+Y4AKVzKQ2Grt3v+fVPav0ThMVyVbW+jThTq1mRRwa4bW8xdEUx9rN6GVVycM/ab4Z
	 0UAEfhJ1MDr1LKbNrSzazz77qckPd/+bz1rCBSdEcjuLi9NHEI/FSlbmdZ1BX1tMcdIZu
	 tYh2VjnbyRiuPYtP71EFQTmct3xHATu/vm+TS7GJQybePe9s4JxR5fySh3jXKAT+0aj/X
	 pnId5OyLMGUzjw2BbdxoFIJ0IvXsF/4jdK2AeReNP3rt9gamrsRgynMmVz3VBK+pwHXJA
	 GGI4xkIgSpZ/3aooozpRsVV0gTIluNdif+fUDlKllRihqPd3Llba0dMzgprF5QDEsdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0trkrO4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D4E606A321;
	Thu, 12 Nov 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0trkrO4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983F51F000C4;
	Thu, 12 Nov 2026 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794502705;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F0trkrO4fFaMukQaQ8tOm6B7bfja4LZr3cuEEY4j6lbSQkWAdqD42ufSwv/IHtyVe
	 GfUZNoNGP3MdIo0dba0e7y10brN+PqbBhuRlWdmup5x5UwwK9/uPax9I6Fya8x+Yzl
	 GJ5eUCBi4mkJ5rfnNW2Tq2L5Ob6wSIOxpsiwHkiikOKY3N8aXyQVAvqymBIHXnQUN1
	 fX2BkGe7IMjsgHMJEA/pUawRvfqUE3LN5b5vXrXzA1SQpCeRtFBmXbBArNz37kcY+7
	 lveJPsVQzsfrOYW2etCYlysJxUVqTmmHHo1Ol5ocgjMPWNbkHD8nxfTrErO2jVDOrN
	 kJP4Zrs0NH5/w==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net v3] net/sched: sch_qfq: revalidate aggregate after peek
Date: Thu, 12 Nov 2026 16:58:25 +0000
Message-ID: <179450270512.2168702.15196225710453075177@kernel.org>
In-Reply-To: <20261112164954.2786444-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112164954.2786444-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
