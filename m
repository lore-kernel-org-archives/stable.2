Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C272EEE60;
	Tue,  9 Jun 2026 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966343; cv=none; b=TFewzwOOIh95orBggorKsafaHCD0zj4emn4gQlsZMX978yWXtv/3sfLhKcxwXnaj/icMizMzP1zUPhgaeRYOQ0631d0xQLWoNbrLh6NrIieQW58OZih9cRU5bzOLmgauccKp7rIAiKBZLNiHOnQyqhUVEN/vHVW98t+UiWLUYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966343; c=relaxed/simple;
	bh=nsjCiLewUQnyThO/nk3vegxsepbxGCb1ZuGqp/NqJp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyVfcuQvIy3w2q7UPahIfhtF7MJ9korN0WdOYyBvioWVU1/BiPQ8XIibbpQfvB/3RMIS+R54ENny8TdgMql9P67iF/3sgLNMXZZ/5KARMHdG7VKnOhQ/d79vaT6U77WCwvzmi0YsTDZbiqdB4Si25qGFNGvvQkQXI/rDHVMiaPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGkWL5D5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGkWL5D5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF8F1F00899;
	Tue,  9 Jun 2026 00:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966342;
	bh=Lc0hJgnYhv04evvGi5aODLz+6yXOmwINNyB7mNxpGvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lGkWL5D5tEnCfZm9gL+fCLycFNvCrsCAV2KhPYPlg4kIJV9TC+uk16i1pDq5Nd0Xt
	 Q+wvGxJDjPm1ikIeaWXc0Q3hSPQQnH10uyFe6FytvAre2ch43nV9R/Oi/BRaImhJtL
	 Kb/kbM0UO2i6BUlOH+P0tlFeLYZEsrFZvzmotiYKPuJViYv65Ieb9nfFNOFEMnhcjh
	 UmezEdM245NpKkZYQMsSPoJYF3eUeSBSmYVxjcKxi6DnqlmqnXIgqr7lQGDqUmcjJl
	 QApSpWYmYw1yBKtyKYD1cBwYb2G6vNr4m9UuPA8OicWVYfV5FPF1ouwiM4gRZV3LJ/
	 C9Qrxc5u3hhXg==
From: Sasha Levin <sashal@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Liebold <lieboldsimonpaul@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Simon Liebold <simonlie@amazon.de>
Subject: Re: [PATCH 6.6.y] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Mon,  8 Jun 2026 20:51:58 -0400
Message-ID: <20260608-stable-reply-0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608082454.2786663-1-simonlie@amazon.de>
References: <20260608082454.2786663-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] xfrm: hold dev ref until after transport_finish NF_HOOK

I'm holding all four of these (6.6, 6.1, 5.15 and 5.10) for now.

As adapted, the backport leaks a netdev reference on the nested transport-mode
path where both an async and a sync decapsulation happen: the inner dev_hold is
balanced by a dev_put that the older trees don't have, so the saved reference
is never released. Mainline avoids this because it has b05d42eefac7 ("xfrm:
hold device only for the asynchronous decryption") as a prerequisite.

-- 
Thanks,
Sasha
