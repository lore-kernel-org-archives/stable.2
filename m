Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484833;
	b=J3JmnavJp5YWTXL/Fs9Spj9TC05nNKfupuAMVD15inO/8ORhLmh4Xg+jULQkhNSWDndI
	 Lhg04zY1lNpKxIsOrngy8YqzaMpMtEZAyURAIZh0lTv97Ikeua+pxPxdwnf2dYzEamS5N
	 0gAr/Dm2ysi399fmQnHLRoVUj1Lxb8Af2wlZp3dzExkKDnjFDGzBgIVRo7iwiQ0PnsKLy
	 5hTcQueWIlr9vSnQk+6OD0hxRHgE9uxU+IPJE7jH7AOw+4qqpqyQhuRew+kBkhRfMLtP7
	 /UrgNeBQAHoLxD1c7xNoWo7BN6SVPLhn2rnYpFJpfwwrKJttzC4xIzG+C/WAuKXxb6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484833;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=zSkGsdaYPXtpAHoYp4I1I9hkVVHnJq95Cu6bpgcwS6N8+XqG/bZvtXnxUUtSvqf5520h
	 l6O777pgLvx8fAWvRFxoWsTf7msIBm62GWfYLSPdmqO/HHPQug3TB2zjEXMYEBDg+vhE0
	 fnVEl51NGQQAO20C8Ov5OpFVkZApiYvAilCvm47kzQdydiAZTpLea+lkQtvjRGU21pNsY
	 jq74Ou4B6jVrdGxsxs9PY4OnM7A+v+nr8Jzuct+/VmerRzCFQ0Cc+MgRPccT9tDnQncH0
	 Aoa/+KIVQIDPjkeB3xmDVgZATNnm4cREhvNoNjYECT4ms05Uyq7iMrtnsd6ErI+8czg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNBUzQSb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851D606A31C;
	Sat, 31 Oct 2026 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNBUzQSb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5691F000C1;
	Sat, 31 Oct 2026 22:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793484833;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNBUzQSblARFpyOX9Rby+Jvb27jKexyppCVGaM4BVKfMQ/+gdgDuwU3zjgNegJ8tN
	 moRmGbSb6SQmmmvPcACQqmPcCWHiQMMAiEO/xZ/ptFu55u9XtParuVmwQDv5iNqTEB
	 ip1dH9TLmJudPbjJ6KZADx4EbzH2/RV0yL9Kxl7eRmuZ+VtK//MTA5TSBLzuFj35yF
	 U9sQU/uCncJnJ/7qwfBVd0B+AndVJ9Xur/cnL4n/1ljBfP6D0opXQ0mFaz8VEpmKRB
	 vCpiS94Zlt57P4ZG5VzPtoig/wb7T1dHK+9bhwAv0pZRzHi/IsDOrgJ2QavtJYvDSx
	 GW0tmTYtX5qOQ==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
 Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] net: qualcomm: rmnet: avoid stale VND access on TX drop
Date: Sat, 31 Oct 2026 22:13:52 +0000
Message-ID: <179348483231.3286.9114649730090471248@kernel.org>
In-Reply-To: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
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
