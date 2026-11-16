Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794797019;
	b=XHuEBk5X8CQExoACatVt3JbuVylad122mTaR8mZp+uR4QU3QgqNHSkTtNN5/M1QT52Ha
	 OhGoyoM+gNsmlcecNM/b05aXdPWk5YIG0fjbDGcZDBCXn2goV/+EAjCH2MWyRyUp6z16S
	 kgxYbD9nND14vsqzngqLO9XgXXc3fyjdeawyNpqlgtHl+SP8W7Au5VFvRrf4iBRCP0PQg
	 /0CcrbDh7gprCq+v9ut56WA9S7oRTLdu2JiNm/HsOxMPwYk4XaloxqHjXSIP1HB/HaS4o
	 VUOpwhcYPNc/Rgf15JdKBmBtn3kfPLZ59EgN9wUkc5OgUGTo8awP/NQUxxpz7Lwos9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794797019;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=EK0sKuPgIi4jWwiwXV1GKeYhYGhXP0Lu1cgrNhsCyNt4vpL/7olujaKmoqzX+k6NEb0C
	 qIRIGF0Kc0O4HM7ZSHRfD+ZWimJXwYGk48m1rkivLf/HD2YqTvkslFqXM16UeTb0wZZ1T
	 tt1So2op0P0QJMJur+xcLczNSb/DkTtg2PYj3x1glpY7ohzNQeSOkfYl3jf9ZaJgdK6Ya
	 84W0DnXvJR0N+vVFoWOM0dkS4UivnK1Tw0nAz6EIGNF2TaZqoNueGkGSWnN3DnoWBAv9e
	 nQzsMN7tPSUpW/6WWZvMqVmGwUku8N+32EGct3PDaHAz4d+aWrNRszy1jSLkyvt5anQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQykc1P8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E6606A31C;
	Mon, 16 Nov 2026 02:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQykc1P8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECC41F000C4;
	Mon, 16 Nov 2026 02:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794797018;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kQykc1P8c9iZaBnHIXfJ0zjCQrpR/S/Yq4kBqg6UkdK90EAzqtGlMJC0l88t44GsW
	 L//Fnt4MEW6r7En9AHmSy3vAtka4TCgp/YGMhE8ENCMODZP01Eqa65z0dYTaE9tHVm
	 ZPZOUOEr5mvY250YIFXnL3neCo+xW9Y6jAo8GzfFPdq3buhjiEp1iWRXzc5k1HE1gH
	 GZuPqW0Nqpi6TDfegZN6Kh3tos+Ddhe1drnuSE7cmkiBHClIxieUYNJbJoXwQEdXW1
	 o8gM+jp/4pwJet24F5Lj/r1boGn9p4Yi1J/U9z3WBJ12mgxxuO+9ar5ld8VylEmXtz
	 Kf43pySmCBe4g==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Yuyang Huang <sigefriedhyy@gmail.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: fix uninitialized heap leak in multicast address dumps
Date: Mon, 16 Nov 2026 02:43:37 +0000
Message-ID: <179479701732.3291.915675964545103961@kernel.org>
In-Reply-To: <20261116024056.1274402-1-bsdhenrymartin@gmail.com>
References: <20261116024056.1274402-1-bsdhenrymartin@gmail.com>
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
