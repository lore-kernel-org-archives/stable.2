Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287152;
	b=qS43F/dPmzVFe3u4XOyezbs1lEf+LZgChFgpYtH4fZXHlfygG2OsZ5OvNabacjSGOm2m
	 +aiKU3lhhZ9SQ/UIH2cFXGXUpzqdsQLhzRT9phdcmzB9/QWZ7KTFZ2wRHXMY79BLwJ9Vq
	 MbN4p+tP8/91o3oPao2NmJmE+HJrrfoIKzCZoqWJinHiuqi94wmjLytbgZCMYsezy7YeP
	 1YGRcyvL+BPVg5/25Dqm2l3Kd7cVKJWQtQAlwszLgfvs0HDsc9we7+UjGk7Wm9dIZ98FK
	 +DhLg4mn2stH66rJMw04T7qeHGMQYnDMCgGRoV/WJwb3BgKj64vBTVFBG88w+wqxLsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287152;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=1XmXasxIXSEJO2sUq3tuMxLD9LWIEr1kOr8AuBTOFEfufNQVXU2vGBfpnEu3d1RTQexT
	 HWRwkA0bFj0ScIC4ucOXEP39u+3SHpnNasIQtcJGEsP3JTApiX3Oi5EdwujYPKr1pf7f6
	 jJPAZyn/0TRFKTBX1m8PeF9qB5PsLSdUkGIZ+DCyfac9mLcycmccAIZfeadl6pFvSH4w5
	 T4w4CYupMcnWHH8NnozwNY70PJq5aN/RLi+joz054Aqc4+Y1owfr+GvQdY12Za4l0/ibW
	 fl6zeLCOS1nYnOTZlEW+mukgQ/sJES/tQPnwIGNNBXkj3SvoTMGmB0njcThsm+ccGOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMuJDDBM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD10606B0B4;
	Tue, 10 Nov 2026 05:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMuJDDBM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD7E1F0089F;
	Tue, 10 Nov 2026 05:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287151;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nMuJDDBMPRIYPEd2mroa1Zp8U2eClRwZMPCTbeJ1mYDJ+mJeDaCLH/c+BOFdNz7M7
	 zUfFD5XdL7sjQTYhIzOf/6oQMxnUqpT7rP64lOe/oFNUxGvtKFpLFx3Skzfc2XJ4E8
	 HbJLN/lJJfRLZ/6PSPFztfGhGsJC7AdRH9TJLFPZ1z5ZrGTLiAZmAqWNwa/3IMXlMA
	 WcPpmNj3ZKBH9hpjujfx99hyhE9YZ5pzx5LYlhJXI4x6I4mVXiJSpUDv9295H6KX11
	 5qUKjpBONJ8zbvdTA7DL1mSP7Lg3zp16ozzdtL6KQzrygmdWaLMIxW1q648KYUx//n
	 fm6t1jcZtD+qA==
From: netdev-bot+sinfo@kernel.org
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Petko Manolov <petkan@nucleusys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net] net: usb: rtl8150: fix rx tasklet use-after-free on
 disconnect
Date: Tue, 10 Nov 2026 05:05:50 +0000
Message-ID: <179428715042.488859.1707985272279776234@kernel.org>
In-Reply-To: <20261110043016.56986-1-mhun512@gmail.com>
References: <20261110043016.56986-1-mhun512@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
