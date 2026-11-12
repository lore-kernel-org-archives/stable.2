Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457903;
	b=SdF0eluuaQF6UWtZGU2ODMm4RVMe/DglIUIZGt336ijTq/h0/On1q/3jQfGTbdGH/0Qp
	 cLYZF0U6agu9p8wR5t1Hhqo3n6T//+K/kVIrIzvTHxv4XHegy/Nd17U1Eyhtr6QxVcoaE
	 I+ov+OO95+kYS7oav/C9Ri9UN9Y4d4r3+1hDxWBQ3AxWx1NgroVt/SQEz3+44TyamklOx
	 opG3IJ3BUgrWta9tFI0BnqsSUtDqVRa0bVC+vAy6gGWezvVxpsChQaedswXJRsg7izbML
	 AN/O/CcDeCPdjjnjyriipfPV/j1DpNRodZ+miDZ+R/zaVzDjHMGv7rGMHPpd9e4V8uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457903;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	b=QQvfsXdIApAaK7qUU6NEPvXXul9yNoOBc4khhASOy5qJbqKQO1xIVTVdfha/dWFI2M4T
	 SrVQwIAVSAN+oY5PbqRirEWwMeMc7I4XaYQyGhiHJN8WplO8phLF3l2Yjk/tiHjh/gJbB
	 cxui3A9NlgWufKXDSzEfPRLOMsrOD+Ugf0FU98ViVwRUDaDm2XIlIQbQOTcYC42Sm9fPI
	 YftFYvLYxwLDKyEjSdseMjmv2dvPrwW0TfRYgUQCSTZi5kkXcz1sCuAMBZunaPbYuTHjg
	 LOV0GPQ0jKQtQ7YZQG0zytSfmJAAkDfNn0rMF6JPbuIuGV86b/uiKfwxsL41l6YP9bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFJx2gWa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB9606A32E;
	Thu, 12 Nov 2026 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFJx2gWa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC611F00A08;
	Thu, 12 Nov 2026 04:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457902;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eFJx2gWaf0PAyGMPKTFN7gA7fFSrZ7L4sJBNQkWDT3FZ49IX0IfFyf4Xes0eo6T0D
	 o/Gw2OlLHQ7ppNa3kbFrNoeAL9g3p35V1SsF72O6amDt586QecTcxaJtOTZFyUCrao
	 aav0RMWLGDApIZG1+EPVulRsW59n1Tlq968s1enfrXnxVWUAesFYjpwdiWUuaVYH83
	 imBWbUyhhQTM0+I56KnlcXFY6it6148+Ido6XDJPWjsyDVu3td8Jyh8ydhbwl1o9PM
	 UC1Jttgm6Z/+KoHE83aIpNKNGR+6omkaOx/8e3INJ8AfFLfBpZi7P+sFTEjfEPdvz1
	 UK3E+hlY5nggA==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ip6mr: prevent info-leak in ip6mr_cache_report()
Date: Thu, 12 Nov 2026 04:31:41 +0000
Message-ID: <179445790170.2168702.5078709310241498166@kernel.org>
In-Reply-To: <20261112042415.617221-1-bsdhenrymartin@gmail.com>
References: <20261112042415.617221-1-bsdhenrymartin@gmail.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
