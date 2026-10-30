Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330972;
	b=5slrV3TQE5evUhfGM0FISPQt/mHtf0qdohqHfldeCiXUwQkaOLpbUOXpRh++RxVd7nPJ
	 UL2+V3OqSVYKCP+BkHkyBKGMQ0IXNfgVBWeB9aSxncWQt9AGF3+InY867OxpMwiHeBao6
	 HPfbGfSRLyPBIJqbbksu6WSsJwVTZ93YKOzT0p/uuTaZ6ALkUv7rKkYLxUaVqN/5+Aieq
	 Y/sidXe1ZdIJXrsEBfdAix4NFLz3Z8XXW3t/YIxdT8Pvzda+9oEFipN92kIyEvZ2RvJaj
	 xyIJKVsukYvhVUOPaOniXeLeWzR3HVyf29D3u32fFh5hRaONFTurAg/8hM/NIxM1pDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330972;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=LoBprTxw4mQdZUhPnDo9BPooOc6Yepc8Y59Vv7nzi7DeT6O+haMqTCwdBMg8CIchXr0I
	 rAxfCDYb+rjHGJcBcXAw2PqBNbmnZN61a90TCTsH4R263l/SDyCMAfYzsYmNPcxtvnyUG
	 0CwddYBObR5ospqYmn15IyBqJ4XgUJ9WQGZKg4bbPBkW7fT8oPqQONIg8+x3/bMvvZHuo
	 ngQtANVJ6EuYym2qqbHxBycNI07ZSClEDA9hpLx0dLOQpys7IxN0zya9WOjpvAWb2Ojyu
	 ymIpBkh8KHo+XnuZ2Hu0+/wkUmyHGLUqOdTXvp+HjNCPvEEoPaxt9mi+Tb4ocxk4jDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlFS5Jti;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB30606A31A;
	Fri, 30 Oct 2026 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlFS5Jti
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24E51F000C1;
	Fri, 30 Oct 2026 03:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793330971;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KlFS5Jti06khpDFPHe0DnZofB1jL95kEEc5qVPI9IGuAPh/JIw4eFrmGw87lXK3gh
	 WC1tqn4V846nN90+wpM5hy+dR4QG0n62axIUUx5ThaTAB2a7jbfPwR7VcF/OwsgPAi
	 Vk7BtT4E0tSmzaKd7EQx8JTBhcJlIO47M75A9If9kOP8ZShAN8R4plNNW4ceSL4kyo
	 gfb/B7FuO5jIWlJZSJznb4B+/ugyLUn/XIjue+WcmrmV/TdJIrSOAkMArfgF3Id7CA
	 dURtV7twv41wb++Z8RKcNP36SBfwwX7tyZe+DWIK+9Ya4Xmj6PRI6qE6HdwiJoeZFO
	 aUiFmKZmH+s6g==
From: netdev-bot+sinfo@kernel.org
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 jchapman@katalix.com, tparkin@katalix.com, gnault@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] l2tp: only return sessions of the given tunnel in
 l2tp_session_get()
Date: Fri, 30 Oct 2026 03:29:30 +0000
Message-ID: <179333097026.3327.6449566722898594878@kernel.org>
In-Reply-To: <20261030032617.4065353-1-hengyul@cs.unc.edu>
References: <20261030032617.4065353-1-hengyul@cs.unc.edu>
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
