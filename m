Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775779;
	b=nCS54zefkgAKXwNHziATL/i+WqCVCME02UqQmM2JRDMaLYH6sBokGjnGFwcctnPzAPdg
	 cuNpabTyRKL5TvAc5mFdeuqPCOYv8/wk9DqtQuBFDsoCiV4e2/6WOvwXZbct43qHfaRqh
	 DLRhTpVuF7xPJWtJsxGyJFCF6IE/2BGkz84x6XLRKNX9DgZQD91AXcZepQR7TVpm51JGi
	 0JvASJwENB7vQaQDOHX9id+3jJz0MdnCsVlwNlvuZxXzGmwvPrcpsLEiMKiYeSxBgLZnX
	 SUh6atuuLKocTjvpLoMJX1CfoT3kwsRXWCixnMhRRPjd2m15Tp5RoNSZDZO7Homq6Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775779;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=t5pCmdQpHnzc+6Q6BD+Kvn4nvV8Jy7oWQCqq3j20B1yD+iT2ufQlGgOayDsMlOKy36LU
	 OGlrf6PCrYSk+ryAsEsBbWLa2qTayPyH7dGenWuvJVP66dZMpLmHMEOVo077eBD04/0k7
	 pl5/N5aft2i11GK01cwwjzKE8Ry3bg6prTOTOBgNcUCnGBlGUFcIMwyNCKahUawe2Nkl2
	 slvLw08dQUADrvxPYDxixPISSiZFAsEooY6wzyVmyrcbT+KwBI/ravonVdjSZEYJu5XoI
	 K8cOsOfEZuafafucae0CZcwbJ1qABeUz24nYPZIwdFZkCUjnHxQMePGDr4QDnrek49A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XO4klKE/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210B606A31B;
	Wed,  4 Nov 2026 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XO4klKE/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0861F000C1;
	Wed,  4 Nov 2026 07:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793775778;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XO4klKE/L6+jZuMq8u1tkGf66I61kdT4gAwvoFSPTYyCeYEKCR4IOFFGtv6s6af9Y
	 bBhZDH/7itFSRVfEdy6a0d7zHbqfhWjVJbcvuYexe3iLehWVyKpuJBzQtpJNYk99cT
	 7xqUhzdV6uhaVREFUOavrzMe2yvxuYfBbdwUDKAzfPx+mBB/ezRiuWMjc0tuSsr+ro
	 X9IC04ettO8P3J5QPbd+beKTIyAFVFMFrYmKtOOFGpeaO8ZZ8XFAqwMHmGYZSBsUMs
	 lphbEINNOpLD+zmn7HwEGaa1QqNqbenrwvRTIN3FO4nKTldsddr7ZC2vEfQ6HouzlA
	 E4UW58K2VSHYQ==
From: netdev-bot+sinfo@kernel.org
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Hariprasad Kelam <hkelam@marvell.com>, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] gve: bound the device reported RSS sizes in the RSS query
Date: Wed, 04 Nov 2026 07:02:56 +0000
Message-ID: <179377577693.488859.16386001996626944255@kernel.org>
In-Reply-To: <20261104070041.1902653-1-yhlee@isslab.korea.ac.kr>
References: <20261104070041.1902653-1-yhlee@isslab.korea.ac.kr>
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
