Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009433;
	b=n/BsXdUEypeLmj+yniZ+QTHsELV8gMlq6PsH3FfGttxEowZkqNVstqz2hJvApt41ln1J
	 7x7a8aglFMUCnk9u0qeIV7H3qNEEorItliAVMNNC9nTW0Rq7rQwJgprMZ0ViBEJ8EEJ08
	 g3wq5+ZmomjvE+wqiVwHGENruaI3GFQmmuXwCx13Ps/Uh1X48P2TCJR+18tTNGZfYR5DZ
	 a2BQbje2CCf/vNABbshVwKV0eFhdHq6fDKvBa6vRB6zXpBoG8lrVfmB4VLC7TKFtNUhtk
	 JWHskeqGSoR0RApAQHzKO2Kir5DhyGWmpGSVgtxFoTO9YKo75HOfkQ9dJbw+mJpHdqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009433;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=QDCNiUAlzSk0IslwM/lRmkANFZMb7xJHDqgwSvH/kRQJNZTp2qCy9Rq1Sc3d06358eLX
	 Z5Dl4jMfvla0XMUeZhiHrzzAUp26wz0m/ncs2wW46nFnyoEtgVMPcp8Sxbd1NUTDQkkq2
	 5pgg00bhYSzqSLl2msBiBHLrXnk61RrW/OBPDZhgxou5W6Dvqiwaa5BGT/Vvw0raf9ICq
	 N+IuOlIn+67ysktvZ9xAgBxYgrOg9c2kxCjrCkkZlRhNNstlZVt1S83x9aEjCA1cigmkV
	 b1jUTGVAfa05wxeaXFhRkpBU0MIhLerkMihfVR5yQebzrZz3l3hoV7sBD5FXvZDpdHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F/M3NPF/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DA60A2627;
	Mon, 26 Oct 2026 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/M3NPF/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4300F1F031E8;
	Mon, 26 Oct 2026 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793009432;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F/M3NPF/Br8o005/u96ghrCOygB+CGZC59nCfmtN+6nMGKw3zRMOKX/CcovbDsYbD
	 Ns4V8rdcicE/pf/BRaJKLdv8dDgV5KLCo01cle85xDgW96453F/m/EdAro5OVM4LGx
	 i5ZyjglFyj7oodljsdLKsAv22fQxMDNdsLwrmWKpyzDr4tha7H35XvWZ7z3gjFvhtq
	 K74ytALx+v6mRkLZfTX+04X4s2a52GTwWzEliCCqrPSn2OfLDLBkrgD7YFd8eB1qZf
	 Miu2KVxHKy99COM0mIt1WK3KsLhCvkKcZUwPrmi84vb+baFlIRcJJzAPb9n85lQR70
	 THKotk4iBaCsg==
From: netdev-bot+sinfo@kernel.org
To: Yu Zhang <yuz08559@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ptp: fix use-after-free in extts_fifo_show() reading
 tsevqs unlocked
Date: Mon, 26 Oct 2026 10:10:31 +0000
Message-ID: <179300943173.3327.14313257768336574486@kernel.org>
In-Reply-To: <20261026100535.68114-1-yuz08559@gmail.com>
References: <20261026100535.68114-1-yuz08559@gmail.com>
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
