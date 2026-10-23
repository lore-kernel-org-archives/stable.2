Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792766797;
	b=DJAsbfOjP1BHcnd6hmSb9B2vsU27wBr4l3v746+xes/9KgRtlp6XI2RtovoRT2pavbtR
	 fYuUO1fqTEQH53PKjTASCPBI9BqhosdUm9MUoE4SQEJr+t7lvo+B2vYEjaIm9yXxdE5Sx
	 lj548qkHHgubw/Cs/0uWDm/uLBtbjG34yT4J7kKo/YCpFZxXIe6FNqIyOjPVHgRnImpdw
	 SwtU/1k9ln0vPoUf07esyX/QQR5YzcGH/TTHoJaqpjJXS/FrasKJVZZ+OUG/PFObS3mqf
	 NnLudtHKSc191Go7y5mVbQ+bOmW744K/grnJ4K8WuGNOXPKl+wrDmfP8u96ESKcYrqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766797;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=4nfbsEHYG9vNEmb4rnwzvHhIgwocgI9/LsZaMR3tQ2wTqX8sdt1UGK2jIvrqqTHsJJar
	 GxRLWN8YTvgnsYNFH0LKB2YfUDZKBGsf0y1gKKavYv5QFVbRrW/DtvMD9dQQ+XZvay3/e
	 45eYrKwM0cbC8fdrEP6el4H/kpKVSvW4gthxC6BcIYZ2vlLGXr1+igEzCJunbCTCmsaT2
	 cxBlSYXjMYu23jQljOis/TjqnYohZXntNA7vt6Fm64WyIjXqR/sOTboyqeV9ckWQZPSnF
	 x2tX5Cvq7mumumKWhtDMUSSjcQlZPzw1uo2B4s/8ZIILAYCZzZrjY0bGyqgB1f5Kxkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lhJ/piKI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C871606A31A;
	Fri, 23 Oct 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhJ/piKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EC91F031E0;
	Fri, 23 Oct 2026 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792766797;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lhJ/piKIfdhNEZoGhWPApUoE3iyAiqiT6YxakXouAHMieRB9JRNjJZ2rsXtEkC0Sz
	 Iz4UQMKC4O5YYzk5SjQSswhNXJz+d3hJj8AGCHl7PoHNtjj4Aw2nV6kuYDPEHU5gEQ
	 2DfR66U++EoB2XuIpYWt7N1ogj1/O51TR8sCV4VVtN+XW16rKHIG/HXjAuVeizX304
	 z0k/jTDE5Xu56K4g3jJXDnhrov0tuAdWx/1fe0RUZrE8Wwo6zR379Q+dFn+ZJ8F8BO
	 taGhhLdhYdtLkeZBPw0zKqo4BJVBBRv/P3BXUjBJ+fyS5Pa/OjBc6G5/bQz4LjXOgs
	 FApBtMmWYJg9A==
From: netdev-bot+sinfo@kernel.org
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiayuan.chen@linux.dev,
 ncardwell@google.com, kuniyu@google.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] tcp: limit tcp_tso_rtt_log to a valid shift count
Date: Fri, 23 Oct 2026 14:46:35 +0000
Message-ID: <179276679566.3327.9704428594683564075@kernel.org>
In-Reply-To: <tencent_31D2FFCCE76C50A695A1270151F825E90906@qq.com>
References: <tencent_31D2FFCCE76C50A695A1270151F825E90906@qq.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
