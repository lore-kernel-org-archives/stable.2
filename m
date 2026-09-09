Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA493D6CC6;
	Wed,  9 Sep 2026 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985603; cv=none; b=tSNx8SB2MUrHS9KmHC95KYjMHL9iOEpfWqPIYLH73Dix6xfvq8V3JC2iYCHIgN6f8O/eF/XXeBvF0Gkr0PA6Vtchw6GCzDNmpeSi9jy6WdVldKwlGhf2cb2jvnQW5PN8Pl+9KxCZq67liSh+JUAT14YFrCelPGvmBhwNp0wuQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985603; c=relaxed/simple;
	bh=bcrBDx+E9GityqwisS/gDbl8B93mWZVXyTirwMdgPfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrQXA5cjwsrSvxA9dKFfbo9CUD3Niuw9Zl1bTTyl6NLzyKDAaW2x1MW03IL0QwGzNaANognSDFTVNoo4QfFP6usIkLbJJuqayOY7vD2RQlEVbIQ9AnQcYf/XknKVZp6bqC8bmV5nektoiccZBDRTqMLHkO12UUeR0Vg/MGmGlkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBFC+SWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBFC+SWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41B31F0089C;
	Wed,  9 Sep 2026 20:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985597;
	bh=Gm8AidewC3VMgRAvdfYK2VSaL7Lra4560NDSnGAEQBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nBFC+SWWKxJFtdXjyzOhNC/Wki2SvwBHT8Q0c9mG/DOKHV1wUoN/dca30jgXPiJV+
	 WBinxY3mobKrciDaZfO6d8i0ZeZesYxikUt7WxgBlJSzbWZ81YK29nCmu4KwI1ps33
	 2+Xm1+jUjWNHX+RC5kavFfeu+Xaiu7mBXfx3LJjRJz/0UychjRJ6aAAw0KfQ3U/Vr1
	 ORDV0VAAO1xU7JZKpby1Vg1QgVpgI+cUWE4ZZe6MurnpmfkgQ7xs4sGEyq9yNNr/+I
	 e/IRrfm7IeEgu/eE6VEL7zLLZv2dX31PlPyKCHqrfRDYz2GV0Zq9rld/ETKczy1W2e
	 k9y3wC+S4172Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
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
Subject: Re: [PATCH 5.15.y] tcp: clear sock_ops cb flags before force-closing a child socket
Date: Wed,  9 Sep 2026 16:26:00 -0400
Message-ID: <2026-09-09-daily-reply-0002-tcp-sock-ops-cb-flags-5-15-reused@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909-cve-2026-74268-5-15-v1-1-37bf2b22cb29@bootlin.com>
References: <20260909-cve-2026-74268-5-15-v1-1-37bf2b22cb29@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.

Queued for 6.6, 6.1 and 5.15, thanks. The 5.15.y version applied cleanly to 6.6 and 6.1 as well, so it was used for both.

-- 
Thanks,
Sasha
