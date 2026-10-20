Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488267;
	b=x2i7UZaD+/zeKKjd+VFXa/4+7+jKAqQrubU1O4ffJzo/5ZGYb0FSZErRZlag+Ff6eGRD
	 taMHG1GNw/fgxuyLUjmJF8dNYTC0QPfaPoCZnbuvqh3Vq8/BrLO2lWZ8xuVO2We5ySKBC
	 ib5iKm4uOcB4exhgkYMazWoXT+nQkGRD80evnvo2TlZRlBuCbi2+JthWnZGCZ1xhP7nR0
	 jrUHSBTxMYLEiH/ZyU7T3/qc/2TUHNs6VCGyZ0zD6hQ/1+ryxeBbDPvgQ7PoR+kuZe4Cd
	 xe/UlllZ7VvqMYuhd3akPN7CB2FgRj9J6OdKi4JktsB4FJBSywQ1UP5ABTyqklbOBCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488267;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=HPDU4wFGpZSpXzlh/OCt3qlLi0YoMeKdoPa1Qo+08eNVd+Zvx+EyOiMIG/YfzGBAR4SW
	 7d80aZ9PFCV02u1n42MDLd55bQ6NskWSIlBebt4iVo19DEG7oPpgXlRVZ0LoUzN0+P4ni
	 xQprfJJmxpJos26daugpTS85QVclOL8pIGQw/HtM4kYiRa3HxjcsI9JAeXJsB5P1cHzU0
	 r9Bccvxd65CAs5LH2UBDbWgsMNuz7Wk/JgV2xZtahrkVoRmJoCCe7KzCh80PAvpus+t7b
	 CGf2Q4UrxL1PIT+ddgxkZfzCaTWByKGeVAE26hlAuXk3KHRs3ZGeS4/CnJrK32H9Q4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMwLoyce;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E7606A319;
	Tue, 20 Oct 2026 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMwLoyce
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D361F000C4;
	Tue, 20 Oct 2026 09:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792488266;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NMwLoycej/ssvbx9ITmRXcNKM6CjL73IYWbfm1z778x8g6jo5t98RRcGulQFXzMfe
	 a0nGgTc99yT6KQPhVnOa1LLzZlk6DogbKvXwDcreDZggxrkulyqapMFoZGH8a+sxnq
	 McwgkO7AqtF+YzOa/n0oFe0molderu5QeYORlfw8lRJUIO5vD/KQFEuHGjN3lTTpLr
	 YV1zUThVqdjKPNKQJIecY2ms8H5a9i7r94gukqFsptV/78S3FAFmI32DE+FhJ41x/M
	 hQWxwSKkrsy6MESybEP64ffQKkyaPlGKtA7o1leXHSCX/tizgp6IiXJYl7iDWe9k36
	 rSpFGKXLH+pJw==
From: netdev-bot+sinfo@kernel.org
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <kees@kernel.org>, Simon Horman <horms@kernel.org>,
 Asim Viladi Oglu Manizada <manizada@pm.me>,
 Eric Woudstra <ericwouds@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] pppoe: delete session hash entries by pointer match
Date: Tue, 20 Oct 2026 09:24:25 +0000
Message-ID: <179248826539.3290.615848934021449047@kernel.org>
In-Reply-To: <20261020092118.47416-1-qingfang.deng@linux.dev>
References: <20261020092118.47416-1-qingfang.deng@linux.dev>
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
