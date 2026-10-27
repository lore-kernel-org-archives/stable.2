Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103015;
	b=prsuqgqv8SC1pBG5B8GGnnJ00V8tcd0rOP5XDBfKt7ZKkL6VCndUb0IyAgofQBzimBqB
	 mqPpQDCjcCbpxFbBsI8c2RWMU1bw6cRWO/VQ5rFqEfuwY4ZhEjQRbcdrSWHFLfaLin4As
	 SP0BfZLb+BIkRUOh6WF7Ty3tLecZ9svXnYw9FecWWKUclgr5lSM0489hmZTDoOXhdWhak
	 m8L1ojxfeUVkTO2f4vP8eyZJICVohJFb9QYG6DAb1klNsG2+2DjUIGLDdpCJ/aDKUpqmX
	 4XOOmBm72Dk7xPkGUh9EjMK4J4mg6dLybzERBWhfw2NAwNWCJBMRz/he/SMFVLtVgEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103015;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=UDtKWVQDL+pFEXF7CceHOFGcGJtZUfQJpmYg9HTHQpmqP4OZjZtLI2hkWMI72oB635f2
	 dr4l70t3w9GhZZ2KJ7OJNsvnSVDiEBmR7D7PJSjlxfPHZiT2mRfMhEKsDHfEqusV8OiGr
	 7VO231nkVPYLgK1Hh+kKtEgHJxm8CH5xgvV/yCnHDPWM41hzdYecWOuKjGy83CvgPpppf
	 xHH3UhhEWNrDqYiexC+nMDDmMTRO1mYLNie/HuqRc5Iay/haEeeBY8Oja9ntEMld5gCOo
	 tkF6dVwhW7Dbqp7KCQJgeO82BZ/a0VC6QOw600IPlMeJ1f4gQZC68c4gfR6ivi4d9WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fk1swWef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86243606A33F;
	Tue, 27 Oct 2026 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fk1swWef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AA71F031E3;
	Tue, 27 Oct 2026 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103015;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fk1swWefcyig7zA32v+pewLpYJn6CTN/5w6TToqyTxeQTFGppgjlhV7s2oowNr4jY
	 hseyZyzbSH0NQxUoEO18iXZqZmON1/rwXDqNnVjtvNO4mDUMWfqi9IbCFPudSZjBMb
	 AEI5VaEBg4XVeTg2Owmp/xYrOy5WKrQIURiLX3zSWf+qFrfC/8BfjUcGFHWOaL/5/I
	 veaGNl2aPAdPiP3U1VPKDeEB3P0m8EFtdtNvX6u/2t/XyBLBvxsPJpe8qtrE4X6/rb
	 yj7Ui1EsyreSIrk159iPkEXjs/FVci+5CXidV7j9wIWgPmyA1Ll9QrVjUz/19LUa8m
	 arz7/dixxH7OQ==
From: netdev-bot+sinfo@kernel.org
To: Federico Musto <federico@rimpianto.com>
Cc: chris.snook@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: atl1c: free the RX buffer when the descriptor
 reports an error
Date: Tue, 27 Oct 2026 12:10:14 +0000
Message-ID: <179310301440.3327.713112000658731384@kernel.org>
In-Reply-To: <20261027115156.17128-1-federico@rimpianto.com>
References: <20261027115156.17128-1-federico@rimpianto.com>
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
