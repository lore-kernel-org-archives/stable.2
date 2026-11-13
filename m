Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612325;
	b=jgSTl+qQ4GDtoWdBKPzPqpficx3P7twPoEz6BoACKB/12ryFfarepFbUPopgqYELgi2J
	 xnuYw1tCtGraoJ/xpDilbwTJXzpN+tIh3YpcOienJcqWoZvEwN9QCOw6SLHRC7IxyzYgm
	 25uBNrTOyzpWze8dDy98IVRfGZ22nclDk6LtexJX9JDjs0K28a9WPGX9YZJgHoYWIX3Qo
	 iE/HGJ3ywD8stt4wxtAt5sWB3Fyp++Y0Qe65AGGFmoJVljXdETsw0GRzElvDNrg0eZV9b
	 NZakjE349EUhbJkicXXj/zFmV6jPM+hVCvjGsuJSlFi8QwrCgc6wOfxzt9JxppLSBsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612325;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+ZI3gexBXpVYPbFMrALtqufJPetOQv+G/61FGO1yoek=;
	b=lcxRNf14pNGWL8RtNlFid8jrsH506szgafXu+10V9qTlcth9fBdIhuT+tfW35iyIy9ru
	 LUfZWdA8OhXww+DygWFyFJrVAVRtMI2pPeMrRPkPK39S01ENS6OhHykRTUzet4iIbhk6W
	 T+bgLVfCGs9qtKIa+YFaBbNYuz7hpp38qtsBp6iZDrIDEj1vDEsvQR8MUhLY7CEbgDZxN
	 HTj73LdJaetbK5wYdM1tGiR4npnxlHE1zPIpvFM2NTA3ZVoE7DnUCKrDh68c3LR5NzDXH
	 Hnj1OK11bKJUYVXT99piqHEOlfY8u+NSwUVo0a+qWyDwf0V8tbr6wD0lLiD2521cmHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNrcmbeS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED5606A88C;
	Fri, 13 Nov 2026 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNrcmbeS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D771F000C4;
	Fri, 13 Nov 2026 23:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794612324;
	bh=+ZI3gexBXpVYPbFMrALtqufJPetOQv+G/61FGO1yoek=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SNrcmbeSPbiBQQGlnAhoi4gcr1VPkhuaO8OU0bwsBCc9kslSU7A2to+s+YfMUxSUl
	 I+cyOxIeqis9su0hFfaYll20UkyYLHOCdAMGgnHE6gAtc8XheMoqcSUAgRTsNtPmaQ
	 RLpgqE0h47XOZCVw3TlQKdI3pMUg0f61GJOP3gfSVAXbkWF7rFk6jkS8jfufaCkgyX
	 D6c14QdmZyyC1Z+2kGHLrSM73A0j1cNImU9zqyFFpPXHdaufgpIZ6c2lvZtbs5/5oh
	 q498Y2Po4G74wnwU1IBd8vAkRMGJxCI7kFgA4pzaySbpMnMT9BD6XtzoiYKROh6KbN
	 7Q/YLuFVmeNCw==
Subject: Re: [PATCH net v7] kcm: reject TLS on attached TCP sockets
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com,
 sd@queasysnail.net, sagi@grimberg.me, hare@suse.de, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 23:25:23 +0000
Message-ID: <179461232334.2199510.12258955725199996955@kernel.org>
In-Reply-To: <20261112232444.2865382-1-rjethwani@purestorage.com>
References: <20261112232444.2865382-1-rjethwani@purestorage.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Fixes: tag covers only one of the two defects the commit
  message says it fixes.

--

kcm: reject TLS on attached TCP sockets

This patch makes kcm_attach() reject TCP sockets that already have a ULP
installed. It also makes tls_init() reject sockets attached to KCM, using
a new kcm_attached flag in tcp_sock. The kcm_attach() type check now uses
sk_is_tcp(), so raw sockets created with IPPROTO_TCP are rejected.

Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55@linux.dev/

> KCM calls read_sock() from its receive callback in atomic context. With
> kTLS RX, this reaches tls_sw_read_sock(), which can sleep. KCM and TLS
> also replace socket callbacks, so detaching KCM can discard TLS handlers.

[ ... ]

> Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
> Cc: <stable@vger.kernel.org> # see backport requirement above

[Severity: Medium]

Does the Fixes: tag cover both of the problems described above?

662fbcec32f4 added tls_sw_read_sock() as the read_sock op, which explains
the sleep in atomic context. The callback replacement problem looks older.
In the parent of 662fbcec32f4, neither kcm_attach() nor tls_init() checked
for the other, so the two could already be stacked.

If KCM is attached first and TLS_RX is enabled afterwards,
tls_sw_strparser_arm() saves psock_data_ready and installs tls_data_ready:

net/tls/tls_sw.c:tls_sw_strparser_arm() {
    ...
	rx_ctx->saved_data_ready = sk->sk_data_ready;
	sk->sk_data_ready = tls_data_ready;
    ...
}

On SIOCKCMUNATTACH, kcm_unattach() then writes the pre-KCM callback back
over tls_data_ready:

net/kcm/kcmsock.c:kcm_unattach() {
    ...
	WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
    ...
}

After that, TLS RX is no longer notified.

Before 662fbcec32f4 the TLS_SW proto_ops also inherited read_sock from
inet_stream_ops. So in either order, strp_read_sock() would call
tcp_read_sock(). KCM's strparser would then take raw TLS ciphertext from
the same receive queue that TLS parses.

This seems to go back to c46234ebb4d1 ("tls: RX path for ktls"). Stable
selection uses the Fixes: commit. Would LTS trees without 662fbcec32f4
(6.1, and 5.15/5.10 while they are still maintained) skip this patch? On
those trees an unprivileged user could still stack KCM and kTLS RX.

Could the Fixes: tag point at c46234ebb4d1, or could the Cc: stable note
say whether pre-6.6 trees are affected? Right now the note only mentions
the 8cc3aef0cb198 dependency.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112232444.2865382-1-rjethwani%40purestorage.com
