Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9C24BBEB;
	Tue,  8 Sep 2026 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828863; cv=none; b=Pqbsc9lHrKejt/AgT9la+UHHsgKN5PO14FwtHoH4PiwCXjsZVkM6b2si5MhiXzr7y9YR/jlfHbFbcGV3nyaEDhdbvmPuSeKgw1cJ/85xigdIzNbh7teNHGESxgmj9cO7boPDhAw96I03lV9Q7oSSWa/IX41Zamm1s1FgOyjxjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828863; c=relaxed/simple;
	bh=keHD22P5u7GcU25YUCK3JCAMQDCPQcmgbuldOD8bRtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6xhrWCqlMOuYDhsUFIsHE51mBilH98GBO7zAbwn+UXRhhxDjJe1i2AmwMZe5+9tARTzMpNs9nMttnf+Awh5ufTb76th+W8H+SMCFdvJXyWlClA3yjbzU3Crvg8OTmkyKt1RgyeChD3U/Rp7ya5t9SypWYasRleoWfIdjJpahs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlbQTO7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlbQTO7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6B81F00A3E;
	Tue,  8 Sep 2026 00:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828860;
	bh=sinPNbVvszar+rNoOMZc/WbG5DEeyFbUdS26S+FsNfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NlbQTO7lIBeWdROAMlUbUd6gkvVJb9OUFNU8hDTK7cLqYn90JglbLsXvpgHOi9cUl
	 2S18Tn+wti7yL5QCB6p/mjocKdw/EIUyCZ/Z5CUU+wonTPiLCz8TrL73yPOpmVZKYL
	 cDHF0qAKvYop+JPboHhadv3uCJWVrq7x+ysOTInzCA5HIAho9rxNBZA/TaIYfobL2C
	 celQxuALcLBNEFQzTWXNDvNEe4FDk5tZlTD9ITu5acqKbXPWZHk8+pdRadO5j71OeS
	 o51xnNEGEAo6JR2PUKX9ZrrNQ3hrouyZFttU6LWe2YWQSvh+MavdR2cBLjcON8nGmP
	 0fmLp0Owq8upw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Lawrence Brakmo <brakmo@fb.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 6.12.y] tcp: clear sock_ops cb flags before force-closing a child socket
Date: Mon,  7 Sep 2026 20:53:53 -0400
Message-ID: <2026-09-07-daily-reply-0014-tcp-dccp-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907-cve-2026-74268-v1-1-cacea38d7fb3@bootlin.com>
References: <20260907-cve-2026-74268-v1-1-cacea38d7fb3@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 990348e5bb457697c2f1f7f7b65154a3334d9d2b ]
>
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done()
> runs without it.

6.12.y still ships DCCP. Its put_and_exit path (dccp_v4_request_recv_sock() ->
inet_csk_prepare_forced_close() -> inet_csk_prepare_for_destroy_sock()) reaches
the same function you relocated, which now unconditionally casts sk to struct
tcp_sock and writes through it. On a DCCP child that's a write past the end of
the smaller struct dccp_sock. Upstream is only safe here because DCCP was
retired by 2a63dd0edf38 ("net: Retire DCCP socket."), about a year before this
fix landed.

Could you send a v2 that guards the call, e.g. only when sk->sk_protocol ==
IPPROTO_TCP, or keep tcp_clear_sock_ops_cb_flags() out of the generic inet_csk
teardown path?

-- 
Thanks,
Sasha
