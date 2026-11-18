Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991954;
	b=vpWjZ0yI8a0KvJvmsfjRI65BO34zRCrtrju2pvP9+9zOb/vKyVGJGC7LdpaYQwzxTLqe
	 1knA4vVxIQ7tapsilPxLunPw/w6GrLASQV8F1JwkiIkGjQZQDugsLxObZsHco5WljpmkM
	 7Dv+jOgcotlGDKZGJuGYq9B9OTa5mIt8zG3AhwGc7+U+uveUxTLEbBl39RQ4Z+o4UW6sS
	 /eIaeMBiiJtuS5PaS8dIpYdfKYTA9GmZyghC/4VWARGX/r0qG8UFMYwdfFXYSChGcJC/v
	 Uq9//GdvzaTlkavB0or81F1bT5eADJi3671kvETD+nTGqk1QBGpJRx1eh3T8k53d/RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991954;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=WVMp419DKHSO5Xcur38q+uK2/4z9NKFydnp8Ie26TvE0PpU62uY2ppURvJ5fWw9VgWcz
	 Bv3RLt4R4K2u6+7//WLMHkObKYczuhEVX5hwdbBlBbl5EC2mAag5wYEz0pTje1lDCQv6F
	 RkR4ukmUZOHdDhq0tiO5JLHI5ToFR3Y8cIobbQPlk0yKI58eeUTpyaKUrrI7eJbDoqLuz
	 Gu/6gi74zU3yslVZxcNTC9cyzXfkwffe5sh9udXz/lZx/ual+F9e8EQgPSYWKRVvEFUqC
	 VGr6omIOHdQjAZbX+Js2Ev1aLpr886nYFQc0Y8lgSI045w2KV0mF8Tx81z8WRriK48A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QRbS/+Rp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024C7606A332;
	Wed, 18 Nov 2026 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRbS/+Rp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD3A1F000C8;
	Wed, 18 Nov 2026 08:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991953;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QRbS/+RpL+tLFnwy93K6+tGjjtKfzK0lbcljPjap+Xq20CcMkfUpuoANY6XzQUyMg
	 kZYw1R7zD1KVyLdO72fnpVjDSfEMZ4HrDIvxxAUwXSB2O9O5MDawE4Qq17oRKu6vKq
	 2IBcluWO/tzx09mf9yhfiJeZZ2YqyAo7HRgrE+0l7DXMKIzuTLUQAlq4T8Z12DbOYr
	 keSH9UtBAU8bgm1toxwzYQMK3yN0EGF/MvjN7ZSS/Fgc9eoTOH+acCIEg0zdIXKXvS
	 1XGShFQ5vVNIR5Ss1a8G8tuurXC2aBwxZss2DH6gx4sSLtupnU1dOy9eYdHp733ONf
	 LPYRtFWy9tkJA==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: initialize sk_peer_lock in cloned sockets
Date: Wed, 18 Nov 2026 08:52:32 +0000
Message-ID: <179499195248.3291.5671100667883228588@kernel.org>
In-Reply-To: <20261118084927.1756747-1-bsdhenrymartin@gmail.com>
References: <20261118084927.1756747-1-bsdhenrymartin@gmail.com>
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
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
