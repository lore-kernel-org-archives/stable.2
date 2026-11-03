Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702135;
	b=ge5u/J7GL4aMgGJdb5a25Ef/GnVVJP1Gdi9c/GwGtUDO2E+hYmNxYzAmH8GeMJdUxue8
	 qwFyp78fLdgVa8GAC/cgPaMXM2SYUUtGSSaGl/bBPqvqEVYV/RT4r2Nyq74ACZ2R2YopL
	 tDYgYP8KzaoPtZxH3sxEftkEDSXb9/qb1OcHTUauol+TUETKcBjYudO8oKlwQ0+vNbyNy
	 CnzPldv9r4b18LxxjTjqrB5nX7q8IN7QBkfX7zz0Z5ds4n09IECGQ7f8LL6gGdYRHluXE
	 PJUrXu1rG9peTSmyqXkK4g4Q0mttJ6OjSKIpem4mVwRx/w/lvTHZm6lsPW7bB/w2Gmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702135;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=l9pDMLKMyD/9e72zHP3VeYODn1ZVOElW8V39KG7fxk52kJWkGE3KBpnn3ntDebrTJXcT
	 JO+FWcoG6NGFhOk1rrBBLBI1iGpiJoUsuhVwY2JKW8uOYWF7ob5rrSkILTTo8NqSNnURL
	 3CCnMUJLh47MVXUNk+/z1QxtZ4A5U3epJvvjJWAWWTpWmfXacIe6wsFjYRdcYp/JYbgZY
	 lcuD3+hzSOao2qCWv4HpSeshcpry/3RvI6qzXS9Xg4vZAyckombNfCM1POieoSsHfSuIo
	 wgsA2pFxfftPVWUh/Ejt8v8ahj5v03ej74w0Q5eFqTMymOFx7G38Knz6y9NE5OoE+fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jsmg4WP/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F560A2603;
	Tue,  3 Nov 2026 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsmg4WP/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8FF1F000C1;
	Tue,  3 Nov 2026 10:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702134;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jsmg4WP/B5uhyUjv+KxkkdIc+gbKbRMkVYi0tAiKdUBDclhj7o8sjrOm6EXj+ZDjW
	 D1fSGaqxFeZVYnQFMViTVGgLs1UcPQdLugiJ7vHNDX4hZ4CNCZ+tcwmV1W0NvbtCA3
	 7pKieN5/cavMKjvIXzZANJc1frcZLC1ec51/lgV1KdMN+XMlbrmmlLQZ8gkbmO0bsU
	 voXxInP6KEDTZkvzcYH90F7hxXFqEheNSE8WRoA3ZioRF5bxe+R61G15U9sLa0DvWr
	 l7yKGMuNXGr1TjHS07cIeUam/ItF7m2ZW2DdjERkkliY078cLNYUpAsvm5mU9Nm5k+
	 vj3E1HABYVuMg==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH RESEND] net: stmmac: drop the runtime PM reference on
 probe failure
Date: Tue, 03 Nov 2026 10:35:33 +0000
Message-ID: <179370213371.488859.11974363299490161840@kernel.org>
In-Reply-To: <20261103102914.1341121-1-vulab@iscas.ac.cn>
References: <20261103102914.1341121-1-vulab@iscas.ac.cn>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
