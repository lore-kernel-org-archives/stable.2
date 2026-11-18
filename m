Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992916;
	b=P+kDY9m4Fv0xFo+XA3ShfIhnwwV+CMPIxK7pibYeSlEEcHmMEhcLWijQLcpgVTPxC7rV
	 E7axS8iCpOMaTutdOmkOozwLVzIBJY3/qONBOEweQNF0Rx4ZeY1yoZySGusscUPrzOYCQ
	 KtCR/cJ/TgvI8TNppBLUnusrZfjASqhL/+l4T/LZAcbmsVNGLexnBpjAApnLOPJ1ZCZHn
	 Wij0n69kaOUfA2A/pM3N2xfyld5bk3UeJqsPGgB0qD4JFErPkGKU+DfybV33Gugz3i6fE
	 bjA7sgYttn3Bg2uZnzGzAqyK/AV5jYsbVNqbSLbYQMCJ+88xIz5AJXW4o7c7NGL4dSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992916;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=t44JdI2xpTCoyEtiq24TS8Wbq8+hILbJg5qoP0cO9xkf9xT986GBwxggDYiZzx0wXF/V
	 wPF9iYsyxxOFnikTV3B9prsbfMQo0rlIKnE+JWXnQpQX3zFXAv5XYd9/Bb5XU3Kxhf+bG
	 GtlDJWvlTSA4X2dSzo2R3R2PzPm1pGAL7/W3OKWGre6QeuXT6agjqNcKVp+EaqSk4F92C
	 03YgVjk/f7ivW1yBuGw+cgUIFARAkEWkKYdcu3mqKaR+RDVwNTF/NUjs565XRdQOgFCjP
	 F2l28l7vMkrtlpFGQXCXzT2QyGezIUp23yxcjXK3viwBQoHz4FI7PfYbrmxof2dwETQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYUnC9K+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F5606A31C;
	Wed, 18 Nov 2026 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYUnC9K+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EB61F000C4;
	Wed, 18 Nov 2026 09:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794992915;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYUnC9K+7trVmiFiR5Hy0oGPSufTyrqxste4yxJ48GPaNLmjSd5CzPy/KZITOMtCb
	 GdQvq4lIHAltCQNKCQApL0aH19qD33DvMSLjgYq99WNXqMdPZ+9/ck6+E/11drRit8
	 yab5kCE0XQGlq8l0M4phrC/+u+ePU0CXI1tM2aTr9JtFYkTTy7hMQLWuI6Vz77/Mdf
	 LafTqr5r1PK1CHhj3qobHoLCOtdPweVvGdEFML9AZAdqGzj0nzBKlifLZXRicz/cC4
	 kRsbrRUeAuFAbIa5sBYjWEoEr4KkgxNAB/ZjwDXGJxZBdq5EEXDowuA3gQHFz7Hfz1
	 n9u5RYy8NJKDA==
From: netdev-bot+sinfo@kernel.org
To: Kenny Hsieh <kenny_hsieh@jabil.com>
Cc: netdev@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] mctp i2c: fix double free of midev on netdev
 register failure
Date: Wed, 18 Nov 2026 09:08:34 +0000
Message-ID: <179499291441.3291.12401068458936131728@kernel.org>
In-Reply-To: <20261118090515.3390034-1-kenny_hsieh@jabil.com>
References: <20261118090515.3390034-1-kenny_hsieh@jabil.com>
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
