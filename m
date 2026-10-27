Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079700;
	b=IsSquLTy9NLfT42HEuHXD7AGzQNPuRnHf3kabVGmONYUm/cOBu5y425Xt9XEe6i/DCmu
	 RH2jIkXDJwMcd7Q9nJi084Hjsy07ZwBTzUsFBQqAo0cSVUecxr/4K3RrGMbEt/LRUZ8hx
	 FLLa7EasADdbjp4xTqAc1tqmxExnVzNeiMc1TFI2DZUh1KQhQCMZYeoF556wQLw+IjUWH
	 wJtp2z1BkR9o5ElxDIRb2/qmvkaU2QqUQxXEyemUMRVBtJKW4uA99J0qBGTICa2KuH7TR
	 +7OVeNieVt9+uAJ45sexfzBAcE3ea8vicECZP8zaxZVmvyjlHXl0EmpyeaeQ0MowcDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079700;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=hjrBQmTl7Z2Rg0zlKSbfOYfvG3//CK/bklVN3bEHTWmmLaiHVBwoUyFtWyFskPOEotrQ
	 2Kq/XKvr+WkUC5e4bDAz5Wpm0DWVob+Oe8Dfe2DOlQQNZ5kfGul5NTyjjiVL8+Vo2Tdz8
	 f96hehqg9R3vkwXxGX4uOYVczkokPJi3AWUI2zFFLS0O/4s5qBV36qXEWi9PrE+ltPenh
	 jEAVDM8kbBxFO/1sR71nEKeFrWsOEdlhtD7YcuslLSxXbP9wcx6xY14WRO6BsYAYDckWQ
	 6cDEIpbr9h0Jf171ZRLZdb7ZkLSIqG0oFEA3gU1dH+H9JIZxA8kR1jYCNDoIogSKpqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVcdrynp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D3606A31B;
	Tue, 27 Oct 2026 05:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVcdrynp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC471F01825;
	Tue, 27 Oct 2026 05:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079699;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NVcdrynpcyPponGBc7ffUtcekmPs3ta8U1ivr9283P3bot5oDGVlh7/nIInfAAwk5
	 MXAarKjxLgYzU6xKQ/3YjtRNJZV6ufXRJSM4NUGq/uA4e0J/iQzKiAnEZTmfyNqNgK
	 SkWqhIdMkIM4K1NQybtyq38d9GhaQv0z/Zd5Y8qs3yEa5BtwLAVBee4RFq6sE/bj+v
	 AFCDnrtLYK9XUroWAB7nPrm/mj60QYQvYGpzAB3d9AGJeR3Tkd2445jQxHn85U1BpU
	 pU4ohC7NwC9Ql+/qZ40z7u7tlxEmThbdoN/4zKaoPv4xJF1xEnbUfc3dDTrcXqKdZf
	 63LFK0GdjXxrQ==
From: netdev-bot+sinfo@kernel.org
To: Kenny Hsieh <kenny_hsieh@jabil.com>
Cc: netdev@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] mctp i2c: fix double free of midev on netdev
 register failure
Date: Tue, 27 Oct 2026 05:41:38 +0000
Message-ID: <179307969867.3327.8394430717039407023@kernel.org>
In-Reply-To: <20261027053715.1623087-1-kenny_hsieh@jabil.com>
References: <20261027053715.1623087-1-kenny_hsieh@jabil.com>
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
