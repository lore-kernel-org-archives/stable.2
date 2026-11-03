Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708955;
	b=guo9kNO3atxFE7v4oNFnww1sGLLgrIC9vX29zGa5LgKzlP00Wf23QVl64Vvocy00mZqy
	 hWrbmS4EHOhTSMfCWzpOBQv92yBbCYLV/XNe8g9VTWskrHDgGksGcxwqgDgT80QuihKvM
	 BC+HYyyjgOq1Jqb0zadtNmqGLSawpZURpTw52tYbnWn++fKHTvFUu2olM01udMCUy/sSs
	 t93lw8kg/aA8o3oJOyPw+WsM+lzkxH0kd3JXuWv0DL1VDimYiNIF0LW3wZwbMqWJ1iVyd
	 2Vtyua0P7DOLyBw4F1rorViTunKaQeMPjeqxRgwo/0N8yyzTAxIAJbtamj1rEpgNULA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708955;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DUyYtY0/ODWml+wjlW+GZawiWsZztBIYKliIpArIvIM=;
	b=bVUxp0nlhJnOUWVn0jFFcyMdeHd68gDUlYeBTJjdhH1Vp+ZS3mCD4M/3VGEza0N7c0fZ
	 6fIYQrBhdxV1zImkZaY8BubjdlOe+nxcFiwPklcCAyeEzBXk8+dynpEHLiBOvHCh2XnpU
	 fUh3ikTGY9DRG910xTd/hF4Q+8s+bsAF9rlLhdqy7fic14ObzeD5gVR0YrdHrFQVwfqpT
	 uDghX6PSsJ7G3ARJEqTEdSrxQmzB6gta5GnOeJuhij9s6+h1NKlvtBHCK20a5T1/cB4f6
	 GlNqFvIi2DFMFAIhSzuFss1bkKrx4RQApHjqEuHUKuvQImDc6W+vY+TMjWTLWzlhDYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FuOZFi7g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7835E606A329;
	Tue,  3 Nov 2026 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FuOZFi7g
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CB9EF1F00919;
	Tue,  3 Nov 2026 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793708955;
	bh=DUyYtY0/ODWml+wjlW+GZawiWsZztBIYKliIpArIvIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FuOZFi7gvZM9i0KCFVY+MbFRT83CKlZXVW1c/zMGlL01IeFLhKm9ANExZwHgYnGjH
	 lDzdtIeko4Y+RR89YJAlRc7qMht6BVg5czhNrji69ZV/F0S0bQWE5SUtPKF9R85N7/
	 6yljfx0vSxi3pU4beygEoFcEPlG/XJkIJm5NpSbl/9qO8mIzB3hCQvJEssQ3MRL42m
	 KSpfAm0oTxTEn9+oLbZbzpJYHiN1B0dapz8GJdlcK33EuWU1z1OO1kR+nzeHGllk4c
	 4wGyl55Pdx/qkprc27S8bORd228J8HwQtRwdMkcFbPeG3mmY/HVQi4U4X6ZbzZ/Z58
	 6zGmpJtfDd+yQ==
Date: Tue, 3 Nov 2026 14:29:11 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org, stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put() call
 to nvme_tls_key_lookup()
Message-ID: <aunTlxXbRJ6ZP63h@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
 <20261103053303.GA1382@lst.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103053303.GA1382@lst.de>

On Tue, Nov 03, 2026 at 06:33:03AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 03, 2026 at 05:02:07AM +0200, Jarkko Sakkinen wrote:
> > Call key_put() before returning -EKEYREVOKED, as the reference count gets
> > incremented by key_lookup().
> 
> Looks good, but I only got this one patch out of a 11 patch series,
> so without the full context it's hard to fully review it.

I can it is just I rather do it on request because some people complain
when doing what you asked :-) Regardless, the bug is independent of any
patch set changes.

I'll summarize the context below (ignore or read).

I tried to tackle: https://lore.kernel.org/lkml/20261101221519.GB2689@quark/

And essentially what I would want is key_type_dead not to exist.

This version is based on module pinning, and  thus not having that
key_put() would keep key type module alive in that case. However, it
turned out this approach will not fly as AF_RXRPC and DNS resolver will
hit the wall given e.g., the remote pinnings.

The approach I'm going for next is to have a type registry instead,
which is independent of the module system (to put story really short).
I think I'm doing this with right process as this really needs a few
trials in order to find patterns that stick.

Br, Jarkko
