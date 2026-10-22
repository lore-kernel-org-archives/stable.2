Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672402;
	b=urbLkyCnlLNQJB84ckTP0w7uzUAj5rThDaoxBgq5J7f/ruEdmGtZTTXPFSkuj2GPJEFx
	 yuojFG5hN2miYfAeOA50JA8sEfVHUV39UceWLyOk1AbSf68dMprZgueIIffXtNt2AvanN
	 f7vvxV3og+cBv/lvEyjGhqk20gvxT+4YAW/ZbXJ8icBXwgAnzx5BNjYpFAPx5v9Oe2j9T
	 UJcl0NSjrcq9bEwmHp0Cp41Ey4Srnb3SXEizWb5ejhT7gZeVBo+m/I8U3QqMfzSasKnJJ
	 txq+JWbV3g2YbjaxkoBu/DsCY5Z7ahZe1CsH9a/s6Q87a24ZVZolDhdy0Uz4nZakXIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672402;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=AQgLzkQrozgIbDjYY3AEngjEn+d9fWFph9ODFSJMbAmi19eq4rgsTsx/CQS2vqx0paT7
	 NSk71EzauSwIo96AONaTtctiXEMocGAqgr6sx2ue0lBOQG1T9KseJhW9uCrXJ+gYf+CFb
	 o73wBlII9/m9hzK0j7iZTSSYglG1IeoI7FlSS7geevz36m7LD5nueRMDASdfZ1YJh2eJm
	 EqmGUMfzA7wTYPXHPhfOVz9bnfc+lmpavSwuttp8irldcRpvBP7/w1BmMreCo7NvMg+qZ
	 HVUmFmYzq2WKtvMzOeqyB1041MfcFCqlVPYs1Rdx+M+44DbrE5bTixIOcOSUExRFM4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlskONQq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFE4606A31B;
	Thu, 22 Oct 2026 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlskONQq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5EA1F000C5;
	Thu, 22 Oct 2026 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792672401;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YlskONQqlGmGMQb9ECFSuCj6onEQohryXk/DM1Ryc5lUbFgr6FXTy3aJ+IE/HYYaK
	 OmPysvA/pHJNLJSi6B1S8auHU3HEa+DQQQP5TY5uqmNsbj1+XGM8RMgBV6SZEUAkRR
	 4V5un+f+zAte0SJbvGE/ctDzua7h/D6RJHF+C8jZhOqrkX2omaJXN7/Ijl6BziJUxa
	 Y1+BKVhUszKrmUvC+WnHEAo4e4ghKE0emT4+HzjUWiPJoHgVxr2yc6Um8/JH3R4/lW
	 jVPG3pxk0rEvw71Fmq97nx5X9wvk0J/0Bi1EsoQ6hnnrCW6gHF71wIrNeRvhggJNqp
	 Dcgp9I/yVBxCQ==
From: netdev-bot+sinfo@kernel.org
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] tcp: limit tcp_tso_rtt_log to a valid shift count
Date: Thu, 22 Oct 2026 12:33:20 +0000
Message-ID: <179267240064.3290.8981594665549104094@kernel.org>
In-Reply-To: <tencent_53CDCF8AA0022B75CF72A294CB9993D2FF07@qq.com>
References: <tencent_53CDCF8AA0022B75CF72A294CB9993D2FF07@qq.com>
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
