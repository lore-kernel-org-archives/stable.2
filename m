Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398101;
	b=pKrx3I21i9+Fr8r9yT4GlG+vSsImXtmPk03oM2Xqz6p2T7McZlmvlv83/1/aVA3X0/WW
	 UkSf58O8azRsr8OXaUQnH+X9Tvv4BsZ0oVsb6MEPTSxlVkkXjFio2j+tIWp5HE0vFH6PJ
	 UquP9TEeZ8VkD/Aeqi8NpIscpat0Ttyn+gf8Oo/oB6UFF/BPal++TAYXW0fwFXSMxCNG7
	 HI+mb92kBad1b3TSkhsG/STrai5Atjfs0xKjbQvr+SN1Tyb7RjkeukbAlQJ2vvn0ZRI+G
	 4nHpSRIMWq1uFGswkusLvJopSDCrm1y/TzUHPoO073MPje0kYcMQDySUY7/A4yGOp4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398101;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=zUI8rJ2y1+m2Eaoh5EtsjGLN4ootg3fG+Cn9GgjUe/Wuofliw3MtymRSIT5Ou0+JBnmG
	 +CNSJaOeP7tCwuNpUqV4OeLTaEZ+qTT+oDlXCEkUJ8OWX6gwWvY+/LSFCNAEmbNm1OAee
	 szNxnr/cKNIM780ENng1zHWMK8X72NXPCaoFqXfil/w9yOp8NA+S8tCnq8cP9FOFYFtph
	 0W7vu3QTXUm6xP6eiDQHh+d7HbXCEYx7mkctGItgGU+wn5/d18QnPNo0zUIvhZheBm+9M
	 XtVmzhqe6uTxWScnQSJdgVUMfl3HI7573fpsLvEcswBzaL+CW31G0K6/KH/kjiH38qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=goL4eCDd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E789606A322;
	Fri, 30 Oct 2026 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=goL4eCDd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7001F00A1E;
	Fri, 30 Oct 2026 22:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793398101;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=goL4eCDdq4PcwCINKh/h2FC/xmJ9uLJGKAEHeYUkLp+BuEMgbhHNf5b9rP3VDEOI4
	 WbiG6EpEyljJAudy10w6ucvlOiBDsjxKEtkgSnjXeJ/trLlvefpNnRdNG5SrnKcl3p
	 3IXtdBXpZ+cyOJvmRSqgebCjJ+nOa83oxUdg8CYRhx3Xl0+j1fJZISX0UlnipGEOXu
	 dYxIoFhEQe4UeAyxLs/NoolZ0c2bywzQMkgRnPsimtK/W943Mf5BDuOXnsKcCEt7Bi
	 EfwIrd5ngBkFNMXx+aX7E59qUDalHz8ObB+cx27WVGLu5bwxbg6QXtGYm3vJtbujyx
	 PPR3LMR3hiu7Q==
From: netdev-bot+sinfo@kernel.org
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>,
 Chris Mason <mason@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Yilin Zhang <yilinzhang@moonshot.ai>,
 stable@vger.kernel.org, Kimi Security Team <bug-report@moonshot.ai>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH net v4] mptcp: do not use Fast Open on MP_JOIN subflows
Date: Fri, 30 Oct 2026 22:08:19 +0000
Message-ID: <179339809972.3286.6931292097714769277@kernel.org>
In-Reply-To: <20261030-mptcp-tfo-mpj-v4-1-e6eff2027342@kernel.org>
References: <20261030-mptcp-tfo-mpj-v4-1-e6eff2027342@kernel.org>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
