Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852575;
	b=C8yZZD/eERiW8pFzSnbKMd/XyxauKm2FKTjKtkWiBAM1qZvLrsRjf1NwflCMK3/wvCAw
	 VKT3FeWPTrwKlNCS/1/FoFMc5pdEMtapNZxe3Xk+JH0vwL7nI+Snp70MYduVz8iqHw3T5
	 H6VwCMN6IsnsuQyxCdDisMNBEUrBUscFQjaMC3DLMapUBaA+MP4RcLgZnB8/J6urcLfAj
	 xKpHhd5gMr8esk5005QnU1RociVuxLJLNx24nzNhMMbYHuz0KGobuBqzNlO/34FGbmjAt
	 idVtNVKW/sfMWMF3qHeTQV7U5hWOF0hRUa9B+E86+a4sfoGA6o8pqqzJt33kfx8544A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852575;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=fMa4BCRwiUBNlgwICTN+M0jVIRF6pPJ/H45rHcILbnDOU4NI7TTnXbGECi9hsLBuMaWI
	 v57SsWvdOQ9Axwr2qNMu1ypPEx9ORZI9HFuzmEThDOUiXItpQ0YPZg/Yu2tSLJ6ya/iOG
	 X7f2vEM/t7z+RRyGWThO82U8w6Mv1i27KSqy+XUqSKA04TqR8mmVY781Bt7gg6dDOJvWg
	 g8fUDXQ5rMJelxDpgjjJjoo1gyFj05o+lhY4LTl0tC877VkWcoRWXblYfEVOmrWdy2Dqb
	 2LRHleU0SfBzbk6KHjlWE2N3uxjQLzhwdIiHkDAW+Ozu4MGbTWRRtKJ2HAE1oiA7brQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzVJ05tq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C69606A31A;
	Sat, 24 Oct 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzVJ05tq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D971F01825;
	Sat, 24 Oct 2026 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792852574;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OzVJ05tql2tEmPmXU8no7otctx41Jv+6BvSY0a/NJGo0G0c9N/FjUYoAucvR5laJ2
	 dJTQ8fR59yuWG9h6VQ7FCqDqvRZdg04RvSDH2EznYGx2FvQ5aeZ71adCiPeApYWIqp
	 XL3s4jo2n2M4vVEhQEYLXzL9EOcHeu19mFWW6RULb9PUONcnjfMkfDF8acZdpwmeHJ
	 mJw7W12UBCUWULvAwZAltDoX+nzfG4EYwIDucWgoURyDDD+Yb1NYWNdks3/LiiIuPo
	 xtSqSSX9+E46qcHK27qQAxplR/1FgaSRdtivK1Sa0RbnsqynGJavMvkc4+FCaDg/gN
	 25N3kUCPDHb4w==
From: netdev-bot+sinfo@kernel.org
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 owen kwan <owen@verialabs.com>, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org, sashiko-bot@kernel.org,
 zdi-disclosures@trendmicro.com
Subject: 
 Re: [PATCH net v2 0/2] net/sched: sch_teql: fix transmit-path regressions
Date: Sat, 24 Oct 2026 14:36:13 +0000
Message-ID: <179285257342.3327.7748817772985184863@kernel.org>
In-Reply-To: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com>
References: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com>
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
