Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148148;
	b=WQpjIbyI8mCkeHOP07YnlvyyDy2f31FdvMQ03P3mvktuYtBHDCgu4r0vPJFM+AImc6Mc
	 LyIPOPIBv0Z++tShmqKriEx1duWXqDsgN6e1+zk+TmT2wqUplT+iqFHeRT9uE4+YHcy/S
	 WqtSzD0TViPKo6m/92j6H3Apr7v1ZDvG4kOtVqfl3FdJ9Ylfx54oMIZt1vbFqstj8BRT5
	 9wGy8YpuTvWjUPKRlI79cjzL3x+ioFTSLCQ1w9ywBBLah4W+GOJYJrq9YZBgCYOqLXo1S
	 tAz/eW/36oJwbvuRqh+j16l3/mGoJZvDgQKRUdDp9dq6nx1df3uzEz89IeGmM5Vzhcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148148;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=WoKVXMnN/oTxrIuvAmOGLkc+i7HnViRc8UexV8vN4tY=;
	b=2mfCTxyjJUnbygtx3szN64BM8VjZw1P3lxB6xcSsNcLv0aZ8vBMSMIGmXkyVYtnV4lEh
	 kTa0pE1hzbcDWBchtbpUiuLyhTPF+QYVyWLED99hQUWEPxQC1Tg5oZ8lJFEsL04V7aIAt
	 XwLJTcQJzCKqM4qIraI95KOR8v1ma6eIrJe5bC9j/bHzF/I5CXcQC2z1hFUDl2jawIhb1
	 f5ryq0LOa1MeLI+7xXgAZ7OmTXGij+IAA9GVVRskLnD1quI3jx4HHbOCsHJgYPSLuSr19
	 +xj8f86SVm4NrEZicF2fJOuyghZkBcIakTsH2r40UseP9BBfv7njRbEcIfc4AsrsACg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSKLreQ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCF606A320;
	Sun,  8 Nov 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSKLreQ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46261F0089F;
	Sun,  8 Nov 2026 14:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794148147;
	bh=WoKVXMnN/oTxrIuvAmOGLkc+i7HnViRc8UexV8vN4tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dSKLreQ98APJqhGSas35e77CZevKFtxb2G1fjKlOcUJ2wu0cRmzUqQRiYwtH0lYON
	 X3kBgkXHV6uvMInAajuN4CtZ10v8+C6IQ1McOk9brSw0CNUgkplc8E0PuMT6ywVOVi
	 3hEJtvLAC7h+iqs37zUHoifMqpTgxw0yTKxs5rMWUKaHQaBMNBULEfZwZv8ktahdaC
	 +RFSUfKbF8pe/r/WL7zhlVI7mafSPV+1FayD+jY1L8U5tuXltjxLmblzWtFuXTb8NF
	 CLqg+8IpaHfIfAbL4I83AhNn1fuemxrH1Q+ApkIObcp+OjRcKtlepBs0VMSs1fKb0b
	 srmzVagNw92qQ==
Date: Sun, 8 Nov 2026 14:29:03 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: qualcomm: rmnet: avoid stale VND access on
 TX drop
Message-ID: <20261108142903.GB18859@horms.kernel.org>
References: <20261101232354.2047804-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179357575311.3286.985235534289993929@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179357575311.3286.985235534289993929@kernel.org>

On Sun, Nov 01, 2026 at 11:29:13PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi Jérémy,

I would appreciate it if you could take a moment to respond to
the questions posed by the bot above.
