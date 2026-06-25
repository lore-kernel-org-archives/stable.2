Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB538A72A;
	Thu, 25 Jun 2026 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384129; cv=none; b=C0vzENsIdwULSA1X/H97c4VSXPjUMj1ykFeuQ6CC5PJi39XlBvmJrPEm25Qh6/taV5eArKTpxoHEXv+JTnIbagvh76y0+Ago7S5JRok9yF768V8GSOH4+3hz6AEgNiIelGOPXeRpLf/pxZTiK8sFP61DoV9uyhJcfJMWWtqclIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384129; c=relaxed/simple;
	bh=RJbzB444OWrgTxvsYUH/llEvnk5lqYsfA9FXH00KzmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoNn8mcbkSbO2tR2ro0C+2BCWi3Rv7OWakcbVv1dagsxTGQvkj2kGhU7VUxB7ppYEkPfpTyESDcQcNAvj7fwZwp2A3HFanpLkGsemGCLcI14k0Hc0VUEkT+eFO/Kg6sB/k34uVCBMOqFhgZutKS4RUE3zW3s5xUIkJ1SJN4qhyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q887776v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q887776v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED841F00A3A;
	Thu, 25 Jun 2026 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384127;
	bh=RJbzB444OWrgTxvsYUH/llEvnk5lqYsfA9FXH00KzmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q887776vUMG3Au1XXl8ruHpHXSLJBXoTWwGgBC2GkpS76taI0r3CtcP4ONfBYk0nl
	 MxnT4LvMooak966yROgF84LrHgXNQY3kPj+pD6X6EE/zdpGN2h7APaImin06wg/9fL
	 xezZOLja3iQCVI4KQDn2akVUNMa/N0s2MyxA+mUJ3rn4kX5uiPnKybTWxrYjhkaQ6Z
	 EiMBGA2r5pofOQ1UA4JN+Wl5yaa1vfibz0LjwsLtt+AtXBbOGH+lgVUyE0rOkJyMav
	 fM0HYtPGNwwJqvM/PfdgpSxDbf3cCJd6ckYgeoLZV73YHaUJpkfsFK9Vfn8I1OvcRr
	 YTEppl7KhC46w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	netfilter-devel@vger.kernel,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH 5.10] netfilter: nf_log: validate MAC header was set before dumping it
Date: Thu, 25 Jun 2026 06:41:50 -0400
Message-ID: <20260625054005.0003.nflog-510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624140117.19799-1-alexevgmart@gmail.com>
References: <20260624140117.19799-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.10] netfilter: nf_log: validate MAC header was set before
> dumping it
>
> --- a/net/ipv4/netfilter/nf_log_ipv4.c
> +++ b/net/ipv4/netfilter/nf_log_ipv4.c

Thanks for the backport - the retarget to nf_log_ipv4.c is right for 5.10.

One gap though: upstream fixed both loggers via the consolidated
nf_log_syslog.c, but in 5.10 the IPv6 logger (net/ipv6/netfilter/
nf_log_ipv6.c) still has the identical unguarded fallback and is left
vulnerable here - which is also Pablo's "why only 5.10?" point.

--
Thanks,
Sasha
