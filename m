Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793575754;
	b=aNdctdu4T5m4XCmVzdnnFMeQxpEeShvf1RZaLzlUsgkb/UlrLSdsNjxqoVwXQqvA/aYn
	 R1HQNG4oyT//nbqdHm0xa+Xjhh/7HOb1a5kil0tIb+/d2HNqXLTOtZ630MD1G/EPl1CpK
	 5Fa1xGVwBn57cOB9QO4hUtoLsm3XAwV3OaPAvNa3u6LEGEua8ECF5V6+pzZQMNAo8MpXw
	 hG21LSx+4I7QWdxyCNXHvy4yK9jaV2kfN5H4UXW6SrU6IP+kzhyM8OUv4eXw0JD3B5Qpd
	 +11Q43UNUAXY+9CoJDPO76J1n0unu2yDw2du0jYLxQV/DtmtRH3yeKIwJERu8VQFdHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575754;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=OCYFttQ3OSTlI0ku8GjOKSGT77ljs1FX7oAM5ohzigJQBfRfNzUHnP1/PQh9Xy/q+UQ2
	 QU5SzrAhT6bcSm40ZuW//FZSqeL7UKKDF/NZM15L3vKdem++Up/9rO2Xb3NrzcBd7K2eo
	 SGPuj4sRw0LpPURPj6RN7hideBYV2i90hbjcQFNPDRtM8IeupnLQMmzats1vQ9kOLgWFf
	 nmUxP1tmzlyJLicTC3v4GEaeiEmzKsAoAHkxRf8JkRLnLJuiPRZN1UHLs8HGnnijYu1fO
	 4pc2fpUO7iBfC/Wzsh3dkmw0/j+6eonPaEuQL1bnM68Jvzd9x0sXvymKBXAgwFQKaqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRaY7aTn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981D606A324;
	Sun,  1 Nov 2026 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRaY7aTn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F421F000C1;
	Sun,  1 Nov 2026 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793575753;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RRaY7aTnpGHN+OYVcPfivGxaprEJdnAmaZJJh0RNxq8LLhhJ2FkyadsoSmnCozsqa
	 1yHcjVnMj3zkIJSJLlkw+I25AwyD4BzXSpkcfAKNX0mlpEPprzxTo8ZDnBxAN3j4W3
	 /4HikHpt773e4dB23YCIIOWrxWuoxZ5+yXyVUL46D/Npvh1MkEYQI9+Ed+4/1je6qQ
	 /uoIBij6IagNv9WxrEJqo/0PR/gWOiWFevzuX1d1HRv9562D8v+y/XkybZJNztTkCS
	 t/hTI5TyeNybs5NB+RjuywDF9VvphTdnNmw2Y1PEZVUyvM4VxLXfJKVcPm3SCckBqK
	 hOraQj7lLeVTw==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
 Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net v2] net: qualcomm: rmnet: avoid stale VND access on TX drop
Date: Sun, 01 Nov 2026 23:29:13 +0000
Message-ID: <179357575311.3286.985235534289993929@kernel.org>
In-Reply-To: <20261101232354.2047804-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261101232354.2047804-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
