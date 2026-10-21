Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565982;
	b=PdNBeoxu0qwYEH+e7vT/bpaTiN+3PTJn31c49V66YG2TuHbB4gSUllhVhgPdBtopDUS6
	 8QbvJdEhwR8q210RzLmuzA6OhHcY4SgV5q8Z1DfLrzuw9Rtcp02eS8Lj0STh0UFzbkQPV
	 4ADrWEoGpoyA2LIBIR2DWsnEYiqm2FK1U1WmSet4LwuqmbkDfOHobzXJPCBvv2qUjzj8f
	 RI98TIdRY7vuL4LhrFqbwjofu94QSt6/H6pHh0MLwgzgPZhL3s1FdW8Yqjcq0xaa135B6
	 ymbzvphgMjRcpKwsKDqCi4i/9pHZB4fOUVRX37mGrcV1r0DUPdIEUKcQbv38hWV0F0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=Kj9/EIEelPXF/OBfPGKY8Fo8faza/HTXekmSvK4n1XLTKJ4vBBBplyELa5RZF/C4Xs2c
	 zHhEBQij+fJ3BEm0WkDyLIfF9yEU1DIvoVN2iyCTK3XaznCr88GP83JSUHL+tFLHv+PIi
	 TkUoh6++PkOkCUBAXuqIeJzFpUilCVke7Qv8PwQsaCDGa5JioPoe3nTCIUyWNpOsGS6Wn
	 jcGgRxVR7+KKA9RSBDtUoQu9PJDwX4h9KOPjT0rY8fNSVzx8ej47uV1CSCQajElKnoPUq
	 e6JwQW+SBTQu8V8QKQmOBkNL+qcD0SfV4kVOD4z7pMzlWHhWbEidwiCUN6vGcd49GBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fRxTGkHS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E7606A319;
	Wed, 21 Oct 2026 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fRxTGkHS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D612E1F000CB;
	Wed, 21 Oct 2026 06:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792565981;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fRxTGkHSbv2xVtLrTXNFg/8nVb0W/qfbkyS0b+AaFDB8mcHdkJrd+6NQ04Z2ilXoD
	 Jh9+8Udw26mrr95KDM8jvlrQS/pGCWL09LJzw0rFdLyDHV6w92sb6pANuq36yKIC4S
	 F+7DWo7X1eUWtUZTUXQlWH4Q9pGrr07w6vQgfz+4hBQuARV68ZBcuc1eTkL1j3n9pu
	 DqmFUooHDePLYfww4ScMmAB5L3apr+KKZvQlND7MyF0RQeBLJV+rZfvIlle7z99icA
	 Ejz1JneFxFg4DTm+ng/jolOdDRHWhUK0s3fKWybfBzjCFDsiWXLANcanNRfCbXVC81
	 +xAjsfzw4a37A==
From: netdev-bot+sinfo@kernel.org
To: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Chengfeng Ye <nicoyip.dev@gmail.com>, stable@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] fou: reserve headroom before pushing the encap header
Date: Wed, 21 Oct 2026 06:59:40 +0000
Message-ID: <179256598037.3290.7472257788897474660@kernel.org>
In-Reply-To: <20261021065517.198322-1-theodorlarionov@gmail.com>
References: <20261021065517.198322-1-theodorlarionov@gmail.com>
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
